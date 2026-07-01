# ocaml-garden-simulation
OCaml command-line simulation of plant growth in a garden grid, with configurable size, update speed, and test coverage.

## How to Run

Make sure you have OCaml and Dune installed.

First, build the project:

```bash
dune build
```

To run the garden simulation, use:

```bash
dune exec bin/main.exe rows columns fps
```

Replace:

- `rows` with the number of rows in the garden
- `columns` with the number of columns in the garden
- `fps` with the update speed/frequency

Example:

```bash
dune exec bin/main.exe 5 5 1
```

This creates a 5-by-5 garden and updates it once per second.

To see the help message, run:

```bash
dune exec bin/main.exe -- -h
```

The program prints a garden using emoji symbols. Your terminal must support Unicode/emoji characters for the display to work correctly.

## Plant Symbols

| Condition | Flower | Tree |
|---|---|---|
| Dead | 🟫 | 🟫 |
| Seed | 🥔 | 🥔 |
| Small | 🌱 | 🌿 |
| Adult | 🍀 | 🌳 |
| Illness | 🥀 | 🌾 |
| FFlower | 🌼 | None |
| SFlower | 🌸 | None |

## How to Run Tests

To run the test suite:

```bash
dune runtest
```

The tests use OUnit2 and QCheck.

For a more detailed explanation of this program, please refer to Design Document.pdf
