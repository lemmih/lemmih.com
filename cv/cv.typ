#import "@preview/fontawesome:0.5.0": *
#import "style.typ": *
#import "elements.typ": *


#set text(font: body-style.font, size: body-style.size)
#set page(
  paper: page-style.paper,
  margin: page-style.margin,
  footer: align(right, "2025-06-21"),
  footer-descent: -page-style.margin.bottom,
)

#table(stroke: none, align: left + horizon, column-gutter: 45pt, inset: 0pt, columns: 2, {
    text(
      bottom-edge: "bounds",
      // stroke: white,
      size: header-style.full-name.size,
      weight: header-style.full-name.weight,
      [David Himmelstrup],
    )
    linebreak()
    // hline()
    // linebreak()
    text(size: header-style.title.size, weight: header-style.title.weight, [Software Enthusiast])
    linebreak()
    v(2.5mm)
    stack(
      dir: ltr,
      spacing: 7pt,
      github("lemmih"),
      email("lemmih@gmail.com"),
      website("lemmih.com"),
      location("Copenhagen", "Denmark"),
    )
  },
  {
    image("media/avatar.png", width: 100pt)
  })

#v(0.5cm)

#show: body => columns(2, body)

#section("Work experience")

#experience(
  "ChainSafe",
  "Protocol Engineer",
  "Remote",
  "January 2022 - March 2025",
  "Lead developer of an in-house Filecoin client. Part of the global Core Devs team, reviewing and proposing protocol changes. Designed new file format that became the default for sharing blocks."
)

#experience(
  "Standard Chartered",
  "Quantitative Developer",
  "Singapore",
  "May 2019 - December 2020",
  "Joined the DevOps team, responsible for managing on-premise services supporting a team of twenty developers. Implemented automated regression testing of a custom pricing platform."
)

#experience(
  "AlphaSheets",
  "Software Engineer",
  "Remote",
  "November 2016 - September 2017",
  "Worked on a parallel scheduling system for spreadsheets with support for multiple programming languages. Written in Haskell, and deployed with Nix."
)

#experience(
  "Better AG",
  "Software Engineer",
  "Zurich, Switzerland",
  "March 2012 - October 2013",
  "Co-designed and deployed a full-stack e-learning platform in an 8-person startup, balancing backend Haskell development with JavaScript frontend engineering across cross-functional roles.",
)

#experience(
  "HAppS",
  "Software Engineer",
  "Remote",
  "February 2006 - March 2008",
  "Designed a series of web-development libraries in Haskell with a small team. Two of the libraries got traction in the open-source community and are still being maintained: happstack and acid-state.",
)

#section("Education")

Graduated in 2019 with a #text(weight: "bold", "BSc") in #text(weight: "bold", "Computer Science") from the #text(weight: "bold", "University of Copenhagen"). Partial credits towards a MSc.

#colbreak()

#section("Public projects")

#project(
  "criterion",
  "https://github.com/bheisler/criterion.rs",
  "Statistics-driven benchmarking library for Rust. Has multiple built-in statistical approaches, as well as dedicated WASM support."
)


#project(
  "rgeometry",
  "https://rgeometry.org",
  "Algorithms and data structures for computational geometry in Rust. The most comprehensively tested geometry library in existence."
)

#project(
  "Reanimate",
  "https://github.com/lemmih/reanimate",
  "Batteries-included library for expressing illustrations and animations as Haskell code. Inspired by 3b1b's manim library."
)

#project(
  "LHC",
  "https://github.com/lemmih/lhc",
  "The LLVM Haskell Compiler is a toy project for exploring the intricacies of the Haskell programming language."
)

#project(
  "haskell-suite",
  "https://github.com/haskell-suite",
  "Toolchest of Haskell libraries for introspection: parsing, scope analysis, name resolution, type inference, etc."
)

#project(
  "cabal-install",
  "https://www.haskell.org/cabal/",
  "Co-founded in 2005 with Isaac Jones, cabal-install has become a key part of the Haskell ecosystem. It is still maintained to this day."
)

#project(
  "acid-state",
  "https://github.com/acid-state/acid-state",
  "Acid-state is a tool for rapid prototyping, adding persistence and ACID guarantees to any Haskell structure without the need for a database."
)

#section("Approach to engineering")

Driven and self-motivated, with a passion for deterministic code and deep property-based testing. Usually writes code in Rust and Haskell, often compiled to WASM, deployed with Nix, and tested with absurd amounts of compute.

