# Contact form

[Frontend Mentor](https://www.frontendmentor.io)'s [Contact form](https://www.frontendmentor.io/challenges/contact-form--G-hYlqKJj) challenge built with [Elm](https://elm-lang.org/).

## Devbox

This project uses a custom development environment managed by [Devbox](https://www.jetify.com/devbox). To begin working on the project you first need to enter the development environment.

```bash
devbox shell
```

## Frontend workshop environment

The UI was built in a custom [frontend workshop environment](https://bradfrost.com/blog/post/a-frontend-workshop-environment/) using [Astro](https://astro.build/). It acts as the single source of truth for the HTML structure, CSS styles, and other supporting assets.

The workshop lives in the `workshop/` directory and there's a [Nushell](https://www.nushell.sh/) script called `workshop` that allows you to manage the environment.

### Usage

```bash
workshop dev     # alias wd - Start the development server
workshop build   # alias wb - Build the project and write it to disk
workshop preview # alias wp - Preview the build locally
workshop clean   #            Remove development and build artifacts
```

## Web application

The web application was built with [Elm](https://elm-lang.org/) and also uses Astro. It realises the UI using [`elm/html`](https://package.elm-lang.org/packages/elm/html/1.0.0/) and it implements the form's logic using [`dwayne/elm-field`](https://package.elm-lang.org/packages/dwayne/elm-field/1.0.0/) and [`dwayne/elm-form`](https://package.elm-lang.org/packages/dwayne/elm-form/1.0.0/).

The application lives in the `app/` directory and there's a Nushell script called `app` that allows you to manage it.

### Usage

```bash
app prepare #           Share the workshop files with the web app
app dev     # alias d - Start the development server
app build   # alias b - Build the project and write it to disk
app preview # alias p - Preview the build locally
app format  # alias f - Format the files
app test    # alias t - Run the tests
app deploy  #           Deply the web app to GitHub Pages
app clean   #           Remove development and build artifacts
```

## Makefile

There is a Makefile that allows you to work across both the frontend workshop environment and the web application.

### Usage

```bash
make        # Or make build
make build  # Build the workshop, share the files with the web app, and build the web app
make deploy # Build and deploy the web app to GitHub Pages
make clean  # Remove development and build artifacts from both workshop/ and app/
```

## Deployment

```bash
make deploy
```

It depends on [`dwayne/deploy`](https://github.com/dwayne/deploy/tree/e6b015c6ce926275db378e6370429f60e649fc9d), my reusable deployment (Bash) script that I packaged with [Nix](https://nixos.org/) and [Nix Flakes](https://zero-to-nix.com/concepts/flakes/).

## Technologies

These are all the technologies I used for this project (listed in alphabetical order):

- [Astro](https://astro.build/)
  - [vite-plugin-elm](https://github.com/hmsk/vite-plugin-elm)
- [Devbox](https://www.jetify.com/devbox)
- [Elm](https://elm-lang.org/)
  - [`dwayne/elm-field`](https://package.elm-lang.org/packages/dwayne/elm-field/1.0.0/)
  - [`dwayne/elm-form`](https://package.elm-lang.org/packages/dwayne/elm-form/1.0.0/)
  - [`elm-explorations/test`](https://package.elm-lang.org/packages/elm-explorations/test/latest)
  - [elm-format](https://github.com/avh4/elm-format)
- [GNU Make](https://www.gnu.org/software/make/)
- [GitHub Pages](https://docs.github.com/en/pages)
- [Nix](https://nixos.org/)
  - [Nix Flakes](https://zero-to-nix.com/concepts/flakes/)
- [Node.js](https://nodejs.org/)
- [Nushell](https://www.nushell.sh/)
- [pnpm](https://pnpm.io/)
- [Sass](https://sass-lang.com/)
