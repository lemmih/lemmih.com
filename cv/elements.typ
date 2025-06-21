#import "@preview/fontawesome:0.5.0": *
#import "style.typ": *

#let hline() = [
  #box(width: 1fr, line(stroke: 0.9pt, length: 100%))
]

#let hline-header() = [
  #box(width: 1fr, line(stroke: 0.9pt + colors.header, length: 100%))
]

#let github(handle) = {
  fa-github(fill: colors.accent)
  h(1pt)
  text(
    size: body-style.size,
    link("https://github.com/" + handle, handle),
  )
}

#let email(address) = {
  fa-envelope(fill: colors.accent)
  h(1pt)
  text(
    size: body-style.size,
    link("mailto:" + address, address),
  )
}

#let website(url) = {
  fa-globe(fill: colors.accent)
  h(1pt)
  text(
    size: body-style.size,
    link("https://" + url, url),
  )
}

#let location(city, country) = {
  fa-map-marker-alt(fill: colors.accent)
  h(1pt)
  text(
    size: body-style.size,
    city + ", " + country,
  )
}

#let calendar(date) = {
  fa-calendar-alt(fill: colors.accent)
  h(1pt)
  text(
    size: body-style.size,
    weight: "regular",
    date,
  )
}

#let section(title) = {
  v(3pt)
  text(size: 15pt, fill: colors.header, smallcaps(title))
  hline-header()
}

#let experience(company, title, location, date, body) = {
  stack(
    dir: ttb,
    spacing: 5pt,
    align(right, date),
    {
      text(size: 10pt, weight: "bold", company)
      text(size: 10pt, " - ")
      text(size: 10pt, location)
    },
    text(size: 16pt, style: "italic", title),
    v(12pt),
    text(size: body-style.size, hyphenate: true, body),
  )
  v(10pt)
}

#let project(title, href, body) = {
  stack(
    dir: ttb,
    spacing: 10pt,
    link(href, text(size: 16pt, style: "italic", title)),
    pad(x: 0pt,text(size: body-style.size, body)),
  )
  v(10pt)
}
