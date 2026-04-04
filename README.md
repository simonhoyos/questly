# Questly

This is a [Next.js](https://nextjs.org) project bootstrapped with `create-next-app`.

## Prerequisites

This project uses [mise](https://mise.jdx.dev/) to manage tool versions like Node.js and pnpm. This ensures that everyone working on the project uses the exact same versions.

### Setting up `mise`

1. **Install mise:** Follow the installation instructions on the [official mise documentation](https://mise.jdx.dev/getting-started.html).
2. **Install project tools:** Once `mise` is installed, run the following command in the root of the project to install the specific versions of `node` and `pnpm` defined in the `mise.toml` file:

```bash
mise install
```

3. **Verify:** You can verify the tools are correctly installed and active by running:
```bash
node -v
pnpm -v
```

## Getting Started

First, install dependencies:

```bash
pnpm install
```

Then, run the development server:

```bash
pnpm dev
```

Open [http://localhost:3000](http://localhost:3000) with your browser to see the result.

You can start editing the page by modifying `app/page.tsx`. The page auto-updates as you edit the file.
