---
name: mudblazor-design-system
description: Build and enforce a token-based design system in a MudBlazor app - one MudTheme with light and dark palettes generated from design tokens, CSS custom properties, typography, elevation, focus rings, motion and reduced-motion rules, and scoped .razor.css. Use when creating or changing a MudTheme, adding dark mode, defining design tokens, styling MudBlazor components, or when the UI looks like default Material Design.
---

# MudBlazor design system

A MudBlazor app should have exactly one source of visual truth: design tokens. The `MudTheme` and the CSS custom properties are both generated from (or kept in step with) those tokens, and components never hard-code colours, fonts, radii or shadows.

For component APIs, providers and known MudBlazor pitfalls, use the `mudblazor` skill. For aesthetic direction, use `frontend-design`. This skill covers the system that sits between them. It targets MudBlazor 8 and 9.

## 1. Tokens first

Keep tokens in one documented place, for example `docs/design-system/README.md` plus `tokens.json`, and mirror them as CSS custom properties in `wwwroot/app.css`:

```css
:root {
  /* colour roles, named by purpose rather than by hue */
  --paper: #F1F2EE;        --surface: #FFFFFF;     --surface-sunken: #E7E9E3;
  --text: #1C2333;         --text-muted: #545C6C;
  --line: #D6D9D1;         --line-strong: #80867C;
  --accent: #263A63;       --on-accent: #FFFFFF;
  --success: #2F6A3E;      --warning: #9A4712;     --error: #B3261E;
  --focus: var(--accent);
  /* type, space, shape, depth, motion */
  --font-sans: "Hanken Grotesk", system-ui, "Segoe UI", sans-serif;
  --font-display: "Alegreya", Georgia, serif;
  --space-1: 4px; --space-2: 8px; --space-3: 12px; --space-4: 16px; --space-6: 24px;
  --radius-sm: 4px; --radius-md: 8px; --radius-lg: 12px;
  --shadow-float: 0 12px 32px rgb(28 35 51 / 0.16);
  --motion-fast: 120ms; --motion-base: 160ms; --motion-slow: 240ms;
  --ease-out: cubic-bezier(0.2, 0, 0, 1);
}
[data-theme="dark"] { /* the same names with dark values */ }
```

Name tokens by role (`text-muted`, `surface-sunken`), not by appearance (`grey-500`), so dark mode is just a different value for the same name.

## 2. One MudTheme built from the tokens

```csharp
public static class AppTheme
{
    private static readonly string[] Sans = ["Hanken Grotesk", "system-ui", "Segoe UI", "sans-serif"];
    private static readonly string[] Display = ["Alegreya", "Georgia", "serif"];

    public static MudTheme Theme { get; } = new()
    {
        PaletteLight = new PaletteLight
        {
            Primary = "#263A63", PrimaryContrastText = "#FFFFFF",
            Background = "#F1F2EE", BackgroundGray = "#E7E9E3", Surface = "#FFFFFF",
            AppbarBackground = "#F1F2EE", AppbarText = "#1C2333",
            DrawerBackground = "#F1F2EE", DrawerText = "#1C2333", DrawerIcon = "#545C6C",
            TextPrimary = "#1C2333", TextSecondary = "#545C6C", ActionDefault = "#545C6C",
            LinesDefault = "#D6D9D1", LinesInputs = "#80867C", Divider = "#D6D9D1",
            Success = "#2F6A3E", Warning = "#9A4712", Error = "#B3261E", Info = "#263A63",
        },
        PaletteDark = new PaletteDark { /* same roles, dark values */ },
        Typography = new Typography
        {
            Default = new DefaultTypography { FontFamily = Sans },
            H1 = new H1Typography { FontFamily = Display, FontWeight = "500" },
            H2 = new H2Typography { FontFamily = Display, FontWeight = "500" },
            H3 = new H3Typography { FontFamily = Display, FontWeight = "500" },
            Button = new ButtonTypography { FontFamily = Sans, FontWeight = "600", TextTransform = "none" },
        },
        LayoutProperties = new LayoutProperties
        {
            DefaultBorderRadius = "8px",
            DrawerWidthLeft = "248px",
        },
    };
}
```

Rules:

- Set every role you use, including `*ContrastText`, in both palettes. A missing dark value silently falls back to MudBlazor's default.
- Keep a comment with the token name next to each value, or generate the class from `tokens.json`, so the two cannot drift.
- `TextTransform = "none"` on buttons: all-caps Material buttons are the most obvious "default template" tell.
- Load the fonts you name (self-host them or use a font provider) and give each family a system fallback.

## 3. Dark mode that follows the system

`MudThemeProvider` can only ask the browser after the circuit is interactive, so read the preference in `OnAfterRenderAsync`:

```razor
<MudThemeProvider @ref="_themeProvider" Theme="AppTheme.Theme" IsDarkMode="_isDark" />

@code {
    private MudThemeProvider? _themeProvider;
    private bool _isDark;

    protected override async Task OnAfterRenderAsync(bool firstRender)
    {
        if (!firstRender || _themeProvider is null) return;
        _isDark = await _themeProvider.GetSystemDarkModeAsync();
        await _themeProvider.WatchSystemDarkModeAsync(OnSystemDarkModeChanged);
        StateHasChanged();
    }

    private Task OnSystemDarkModeChanged(bool isDark)
    {
        _isDark = isDark;
        StateHasChanged();
        return Task.CompletedTask;
    }
}
```

If the user can override the choice, store it (cookie or profile) and keep it in a small scoped `ThemeState` service so every layout reads the same value. Also set `data-theme` on `<html>` if your own CSS tokens depend on it.

## 4. Using the theme in components

- Prefer component parameters: `Color="Color.Primary"`, `Typo="Typo.h2"`, `Variant`, `Dense`.
- In CSS use MudBlazor's variables or your own tokens: `var(--mud-palette-primary)`, `var(--mud-palette-text-secondary)`, `var(--mud-palette-lines-default)`, `var(--surface-sunken)`.
- Never write a hex value in a `.razor` or `.razor.css` file. If a colour is missing, add a token.
- Scoped CSS reaches MudBlazor's inner markup only through `::deep`:

```css
/* TaskList.razor.css */
.task-list ::deep .mud-list-item:hover { background: var(--surface-sunken); }
```

## 5. Elevation

Material shadows on every card make a page look generic and noisy.

- `Elevation="0"` on `MudAppBar`, `MudDrawer`, `MudPaper` and `MudCard` that sit on the page. Separate surfaces with a 1px `var(--line)` border or a change of background.
- Keep elevation only for things that float above the page: `MudDialog`, `MudMenu`, `MudPopover`, `MudSnackbar`. Use one shadow token (`--shadow-float`) for all of them.

## 6. Focus

Every interactive element needs a visible focus indicator that meets WCAG 2.2 (2.4.7 Focus Visible, 2.4.11 Focus Not Obscured):

```css
:where(a, button, input, select, textarea, [tabindex]):focus-visible,
.mud-button-root:focus-visible,
.mud-icon-button:focus-visible {
  outline: 2px solid var(--focus);
  outline-offset: 2px;
}
```

- Never `outline: none` without a replacement.
- Check the focus colour against both palettes; it needs 3:1 contrast with what is next to it.
- `MudIconButton` with no text needs `aria-label`. Dialogs must move focus inside when they open and back to the trigger when they close (MudDialog does this; custom overlays must too).

## 7. Motion

Motion explains a change; it is never decoration.

- Animate in response to an action: an item added to a list slides in, a dialog fades and scales from 98%, a saved state confirms. Nothing animates just because the page loaded.
- Durations: 120ms for small state changes, 160–200ms for entrances, up to 240ms for larger panels. Exits are faster than entrances. Use ease-out for entrances.
- Animate only `transform` and `opacity`. Never animate `width`, `height`, `top`, `left`, `margin` or `box-shadow` on large areas.
- Blazor re-renders can restart CSS animations. Trigger motion by adding a state class (`is-new`, `is-open`) and removing it, and give list items a stable `@key`.
- Respect reduced motion globally:

```css
@media (prefers-reduced-motion: reduce) {
  *, *::before, *::after {
    animation-duration: 0.01ms !important;
    animation-iteration-count: 1 !important;
    transition-duration: 0.01ms !important;
    scroll-behavior: auto !important;
  }
}
```

For deeper work use `review-animations`, `improve-animations`, `animate`, `fixing-motion-performance` and `design-motion-principles`.

## 8. Contrast and colour checks

- Body text 4.5:1 against its background; large text (24px, or 18.66px bold) and UI parts such as input borders and icons 3:1. Check both palettes.
- Never rely on colour alone for status: pair it with an icon or text (`MudChip` with `Icon`, `MudAlert` with a title).
- `TextSecondary` and disabled text are where contrast usually fails; check them first.
- See `better-colors`, `better-accessibility` and `accessibility`.

## Review checklist

- [ ] Tokens documented in one place; CSS variables and `MudTheme` agree
- [ ] `PaletteLight` and `PaletteDark` set every role in use, including contrast text
- [ ] No hex values in `.razor` or `.razor.css` files
- [ ] Custom fonts loaded, with fallbacks; buttons not all-caps
- [ ] `Elevation="0"` on page surfaces; one float shadow for overlays
- [ ] Visible `:focus-visible` ring on every interactive element in both themes
- [ ] Icon-only buttons have `aria-label`
- [ ] Motion only on `transform`/`opacity`, 120–240ms, and disabled under `prefers-reduced-motion: reduce`
- [ ] Contrast checked in light and dark
