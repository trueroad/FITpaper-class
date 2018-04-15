\version "2.19.81"
\include "lilypond-book-preamble.ly"

#(set-global-staff-size 14)

upper = \relative
{
  \clef treble
  \key c \major
  \time 4/4
  \tempo "Allegro" 4 = 96

  r16_\mf c'( d e  f d e c g'8) c b^\prall c |
}

lower = \relative
{
  \clef bass
  \key c \major
  \time 4/4

  r2 r16 c( d e f d e c) |
}

\score
{
  \new PianoStaff
  <<
    \new Staff = "upper" \upper
    \new Staff = "lower" \lower
  >>
  \layout {}
  %\midi {}
}
