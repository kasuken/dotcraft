---
name: bunit-testing
description: Write Blazor component tests with bUnit 2.x and xUnit - rendering with parameters, finding elements, triggering events, waiting for async state, injecting services, emulating JS interop, faking auth and navigation, render modes, and testing MudBlazor components. Use when adding or fixing component tests, testing a .razor component, or migrating bUnit 1.x tests (TestContext, RenderComponent, SetParametersAndRender) to 2.x.
---

# bUnit 2 component tests

bUnit renders Blazor components in memory, without a browser, so component tests run as fast as unit tests. Use it for component behaviour (what renders for a given state, what happens on click, which service calls are made). Use Playwright (`playwright-blazor-testing`) for full flows across pages, real JavaScript and real CSS.

## bUnit 1.x names to avoid

Many examples online, and some other skills, still use the 1.x API. In 2.x:

| 1.x | 2.x |
|---|---|
| `TestContext` | `BunitContext` (also `IAsyncDisposable`) |
| `RenderComponent<T>(...)`, `SetParametersAndRender(...)` | `Render<T>(...)`, and `cut.Render(...)` to re-render |
| `IRenderedComponent<T>` from `RenderComponent` | `IRenderedComponent<T>` from `Render` |
| `FakeNavigationManager` and other `Fake*` doubles | `BunitNavigationManager`, `Bunit*` |
| `DisposeComponents()` | `await DisposeComponentsAsync()` |
| `ComponentParameter` / `ComponentParameterFactory` | parameter builder lambda |

## Project setup

```xml
<ItemGroup>
  <PackageReference Include="bunit" />
  <PackageReference Include="xunit.v3" />          <!-- or the xUnit version the repo already uses -->
  <PackageReference Include="AwesomeAssertions" /> <!-- or the repo's assertion library -->
</ItemGroup>
<ItemGroup>
  <ProjectReference Include="..\Product.Web\Product.Web.csproj" />
</ItemGroup>
```

Test projects for Razor components use `Microsoft.NET.Sdk.Razor` if the tests themselves are written as `.razor` files; plain `.cs` tests can use `Microsoft.NET.Sdk`.

## Anatomy of a test

```csharp
public class CounterTests : BunitContext
{
    [Fact]
    public void Clicking_increment_raises_the_count()
    {
        // Arrange
        var cut = Render<Counter>(ps => ps
            .Add(p => p.InitialCount, 2)
            .Add(p => p.OnChanged, (int value) => { /* capture */ }));

        // Act
        cut.Find("button.increment").Click();

        // Assert
        cut.Find("output").MarkupMatches("<output>3</output>");
    }
}
```

- `Render<T>(ps => ps.Add(...))` passes parameters. Use `.AddChildContent(...)` for `ChildContent`, `.AddCascadingValue(...)` for cascading values, `.SetAssignedRenderMode(RenderMode.InteractiveServer)` to emulate a render mode.
- `cut.Find(css)` returns one element and throws if none; `cut.FindAll(css)` returns all. `cut.FindComponent<TChild>()` finds child components.
- Events: `.Click()`, `.Change(value)`, `.Input(value)`, `.Submit()`, `.KeyDown(...)`; each accepts the matching event-args type.
- `MarkupMatches` compares HTML semantically (whitespace and attribute order don't matter). Use `diff:ignore` or `diff:ignoreAttributes` for parts you don't care about.
- Re-render with new parameters: `cut.Render(ps => ps.Add(p => p.Value, "Bar"))`.
- Select elements by role, label text or a stable `data-testid`, not by MudBlazor's internal CSS classes, which change between versions.

## Async components

Components that load data in `OnInitializedAsync` render more than once. Wait instead of sleeping:

```csharp
var cut = Render<OrdersPage>();
cut.WaitForAssertion(() => cut.FindAll("tr.order-row").Count.Should().Be(3));
// or
cut.WaitForState(() => cut.FindAll("tr.order-row").Count == 3, TimeSpan.FromSeconds(2));
// or
cut.WaitForElement("[data-testid='orders-empty']");
```

To run code on the renderer's thread (for example to call a method on the component instance), use `await cut.InvokeAsync(() => cut.Instance.RefreshAsync())`.

## Services

Register what the component injects on `Services` before the first `Render`:

```csharp
Services.AddSingleton<IOrderService>(new FakeOrderService(orders));
Services.AddSingleton(TimeProvider.System);
```

Prefer small hand-written fakes over mocking libraries for application services; they read better and survive refactoring.

## JavaScript interop

bUnit's `JSInterop` runs in strict mode and throws on any call you haven't set up. That is useful for your own JS; for third-party libraries switch to loose mode.

```csharp
JSInterop.Setup<string>("getPageTitle").SetResult("Orders");
JSInterop.SetupVoid("startAnimation");
var module = JSInterop.SetupModule("./Components/Chart.razor.js");
module.SetupVoid("render", _ => true);

JSInterop.Mode = JSRuntimeMode.Loose; // unknown calls return default
JSInterop.VerifyInvoke("startAnimation");
```

## Authentication and authorisation

```csharp
var auth = AddAuthorization();               // call on `this` when inheriting BunitContext
auth.SetAuthorized("ada@example.com");
auth.SetRoles("Admin");
auth.SetPolicies("CanEditBilling");
auth.SetClaims(new Claim("tenant", "t-42"));

var cut = Render<BillingPage>();
```

`AddAuthorization()` with no further calls leaves the user unauthenticated; `SetAuthorizing()` emulates the "checking" state.

## Navigation

```csharp
var nav = Services.GetRequiredService<BunitNavigationManager>();
cut.Find("a.details").Click();
nav.Uri.Should().EndWith("/orders/42");
```

`nav.History` lists every navigation, including `replace` and `forceLoad` flags.

## Testing MudBlazor components

```csharp
public abstract class MudTestContext : BunitContext
{
    protected MudTestContext()
    {
        Services.AddMudServices();
        JSInterop.Mode = JSRuntimeMode.Loose; // MudBlazor makes many JS calls
    }

    // Popovers (MudSelect, MudMenu, MudAutocomplete) and dialogs render through providers.
    protected IRenderedComponent<MudPopoverProvider> RenderPopoverProvider() => Render<MudPopoverProvider>();
    protected IRenderedComponent<MudDialogProvider> RenderDialogProvider() => Render<MudDialogProvider>();
}

public class DeleteTaskTests : MudTestContext
{
    [Fact]
    public async Task Delete_asks_for_confirmation()
    {
        var dialogs = RenderDialogProvider();
        var cut = Render<TaskRow>(ps => ps.Add(p => p.Task, new TaskDto(1, "Write tests")));

        cut.Find("[aria-label='Delete task']").Click();

        dialogs.WaitForAssertion(() =>
            dialogs.Find(".mud-dialog").TextContent.Should().Contain("Delete \"Write tests\"?"));
    }
}
```

- Render the provider first, then the component; assert on the provider's markup, because that is where the popover or dialog content appears.
- For `MudSelect`, open it with a click on the input, then find the items inside the popover provider.
- Snackbars: register a fake `ISnackbar` and assert on what was added, rather than rendering `MudSnackbarProvider`.
- Test your component's behaviour, not MudBlazor's: don't assert on `.mud-*` class names unless they are the behaviour (for example, an error state).

## What to test

- Every state: loading, empty, error, populated.
- Every user action and the service call or event it triggers.
- Authorisation: what an unauthorised user sees, and that forbidden actions are absent, not just disabled.
- Accessibility basics that markup can prove: buttons have accessible names, inputs have labels, `aria-live` regions announce results.

Avoid tests that only restate the markup or that pass whatever the component does (see `test-anti-patterns`).
