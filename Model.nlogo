__includes [ "setup.nls" "dijkstra.nls" "departure_curves.nls" "residents.nls" "buses.nls" ]

extensions [profiler gis csv ]

breed [ nodes node ]
breed [ residents resident ]
breed [ tourists tourist ]
breed [ buses bus ]

nodes-own [
  node-id
  to-node1 to-node2 to-node3 to-node4
  coord
  pop-init
  pop-here
  tour-init
  previous-node
  node-cost
;  initial-pop
  has-bus-stop
  with-bus
]

links-own [ link-cost ]

residents-own [
  my-path
  my-veloc
  reaction-time
  target-bus-stop
  next-node
  r-state
  my-bus
  resident? ;true is resident, false is tourist
]

tourists-own [
  my-path
  my-veloc
  reaction-time
  target-bus-stop
  next-node
  r-state
  my-bus
]

 buses-own [
  b-home
  next-node
  target-stop
  remaining-capacity
  wait-timer
  current-stop
  trip-count
  b-state  ; "waiting", "to-shelter", "returning"
  passengers
  b-path
  b-veloc
]

;=========================================================================================================
; SETUP
;=========================================================================================================
;Residents
to setup
  clear-all
  if seed? [ random-seed seed ]
  setup-world
  setup-globals
  update-background
  setup-nodes
  setup-links
  setup-bus-stops
  setup-residents
  setup-tourists
  setup-buses
  ask tourists [ set breed residents set resident? false ]
  set total-pop-at-risk count residents
  if create-paths? [ assign-paths-to-bus-stops ]
  reset-ticks
  reset-timer
end

;========================================================================================================
; MAIN
;=========================================================================================================
to go
  go-residents
  go-buses
  if ticks = tsunami-arrival-time * 60 [ output-print (word "Time taken: " timer " seconds") stop ]
  if count residents = 0 [  output-print (word "Time taken: " timer " seconds") stop ]
  tick
end


; ====== REPORTERS ======

to-report scale [ a ]
  report a / world-scale
end

to-report temporal-scale [ t ]
  report t / fps
end
@#$#@#$#@
GRAPHICS-WINDOW
8
10
1343
221
-1
-1
1.5
1
10
1
1
1
0
0
0
1
-442
442
-67
67
0
0
1
ticks
30.0

BUTTON
363
502
427
535
NIL
setup
NIL
1
T
OBSERVER
NIL
S
NIL
NIL
1

CHOOSER
14
253
230
298
Background
Background
[0 "Google Satellite"] [1 "Esri Topo World"] [2 "Esri Street"] [3 "Esri Light Gray"]
3

BUTTON
15
300
229
333
Update Background
update-background
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

OUTPUT
743
250
1140
601
13

INPUTBOX
1168
277
1273
337
start-node-who
126.0
1
0
Number

INPUTBOX
1275
277
1376
337
end-node-who
276.0
1
0
Number

BUTTON
14
369
228
402
Turn ON/OFF node labels
turn-on-off-node-labels
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

BUTTON
1169
340
1274
373
Show path
show-random-path
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

BUTTON
1276
340
1377
373
Reset nodes
reset-random-path
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

BUTTON
13
335
227
368
Turn ON/OFF network
turn-on-off-network
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

TEXTBOX
68
234
196
252
== ENVIRONMENT ==
11
105.0
1

TEXTBOX
288
334
407
352
== MODELLING ==
11
0.0
1

BUTTON
651
286
714
319
NIL
go
T
1
T
OBSERVER
NIL
G
NIL
NIL
1

TEXTBOX
1185
258
1370
286
== CHECK A RANDOM PATH ==
11
0.0
1

INPUTBOX
268
364
397
424
tsunami-arrival-time
120.0
1
0
Number

TEXTBOX
281
350
431
405
Insert ETA in minutes
11
0.0
1

SWITCH
256
292
346
325
seed?
seed?
0
1
-1000

BUTTON
247
539
432
572
Create "agents-path.csv"
export-agent-paths
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

INPUTBOX
350
266
426
326
seed
100.0
1
0
Number

SWITCH
265
465
407
498
create-paths?
create-paths?
1
1
-1000

BUTTON
247
574
433
607
Import "agent-paths.csv"
import-agent-paths
NIL
1
T
OBSERVER
NIL
D
NIL
NIL
1

TEXTBOX
269
430
419
472
Turn ON if you do not have a file of \"agent-paths.csv\"
11
0.0
1

TEXTBOX
258
249
408
277
The seed is to ensure replication
11
0.0
1

INPUTBOX
1169
408
1260
468
resident-who
2672.0
1
0
Number

BUTTON
1263
433
1412
466
Show resident path
show-resident-path
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

BUTTON
12
404
228
437
Turn ON/OFF residents labels
turn-on-off-residents-labels
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

TEXTBOX
294
230
382
248
== SETUP ==
11
105.0
1

TEXTBOX
1172
387
1373
415
== CHECK ONE RESIDENT PATH ==
11
0.0
1

TEXTBOX
237
228
254
592
||\n||\n||\n||\n||\n||\n||\n||\n||\n||\n||\n||\n||\n||\n||\n||\n||\n||\n||\n||\n||\n||\n||\n||\n||\n||
11
0.0
1

TEXTBOX
635
226
650
590
||\n||\n||\n||\n||\n||\n||\n||\n||\n||\n||\n||\n||\n||\n||\n||\n||\n||\n||\n||\n||\n||\n||\n||\n||\n||
11
0.0
1

TEXTBOX
721
227
736
591
||\n||\n||\n||\n||\n||\n||\n||\n||\n||\n||\n||\n||\n||\n||\n||\n||\n||\n||\n||\n||\n||\n||\n||\n||\n||
11
0.0
1

TEXTBOX
649
229
723
247
== RUN ==
11
105.0
1

TEXTBOX
746
229
896
247
== OUTPUTS ==
11
105.0
1

TEXTBOX
1150
227
1165
591
||\n||\n||\n||\n||\n||\n||\n||\n||\n||\n||\n||\n||\n||\n||\n||\n||\n||\n||\n||\n||\n||\n||\n||\n||\n||
11
0.0
1

TEXTBOX
1166
229
1316
247
== HELPERS ==
11
105.0
1

INPUTBOX
138
553
225
613
patch-size-n
1.5
1
0
Number

MONITOR
1171
506
1295
551
Evacuated residents
safe-r
17
1
11

BUTTON
1169
470
1234
503
move
ask resident resident-who \n[ carefully [ set next-node first my-path \n  face next-node  fd 0.134 \n  if distance next-node < 0.2\n    [ set my-path but-first my-path ] \n    ] [ print error-message ] ]
NIL
1
T
OBSERVER
NIL
M
NIL
NIL
1

BUTTON
1237
470
1308
503
Inspect
inspect resident resident-who\nask resident resident-who [ set shape \"default\" set color black ]
NIL
1
T
OBSERVER
NIL
I
NIL
NIL
1

BUTTON
12
439
136
472
Scale up nodes
ask nodes [ set size size * 2]
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

BUTTON
13
473
136
506
Scale down nodes
ask nodes [ set size size / 2 ]
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

BUTTON
12
508
136
541
Scale up residents
ask residents [ set size size * 2 ]
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

BUTTON
12
542
136
575
Scale down residents
ask residents [ set size size / 2 ]
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

BUTTON
12
577
137
610
Hide/Show residents
ifelse [hidden?] of one-of residents\n [ ask residents [ set hidden? false ] ]\n  [ ask residents [ set hidden? true ] ]
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

INPUTBOX
399
363
501
423
departure-mean
15.0
1
0
Number

PLOT
435
457
635
607
Departure Times
time (s)
Frequency
0.0
300.0
0.0
200.0
true
false
"" ""
PENS
"default" 1.0 1 -16777216 true "histogram [reaction-time / 60] of residents" ""
"ETA" 1.0 1 -2674135 true "plotxy (tsunami-arrival-time) 200" ""

MONITOR
508
610
635
655
No reaction
count residents with [ reaction-time > tsunami-arrival-time * 60 ]
17
1
11

TEXTBOX
271
511
358
529
[1] SETUP ==>
11
0.0
1

MONITOR
137
440
210
485
Node Size
[size] of node 220
17
1
11

MONITOR
138
507
212
552
Resid Size
one-of [size] of residents
17
1
11

MONITOR
745
603
869
648
Number of residents
count residents with [ resident? ]
17
1
11

BUTTON
644
573
722
606
profiler
profile
NIL
1
T
OBSERVER
NIL
P
NIL
NIL
1

INPUTBOX
430
225
512
285
num-buses
20.0
1
0
Number

INPUTBOX
513
226
601
286
bus-capacity
80.0
1
0
Number

INPUTBOX
430
286
530
346
bus-wait-time
3.0
1
0
Number

TEXTBOX
533
290
643
318
Time to wait at bus stop. In minutes
11
0.0
1

PLOT
1314
469
1596
685
Safe
time (s)
Evacuation rate (%)
0.0
10.0
0.0
1.0
true
true
"" ""
PENS
"All" 1.0 0 -16777216 true "" "plot (safe-a / total-pop-at-risk ) * 100"
"Residents" 1.0 0 -13345367 true "" "plot (safe-r / (total-pop-at-risk - no-of-tourists) ) * 100\n"
"Tourists" 1.0 0 -5825686 true "" "plot (safe-t / no-of-tourists) * 100"

BUTTON
651
322
714
355
1 go
go
NIL
1
T
OBSERVER
NIL
1
NIL
NIL
1

SLIDER
434
422
634
455
no-of-tourists
no-of-tourists
0
10000
4647.0
1
1
pers.
HORIZONTAL

CHOOSER
503
376
633
421
bus-strategy
bus-strategy
"far to close" "close to far"
0

MONITOR
871
602
1002
647
Number of tourists
count residents with [ not resident? ]
17
1
11

MONITOR
1171
552
1295
597
Evacuated tourists
safe-t
17
1
11

MONITOR
1173
598
1294
643
Evacuated All
safe-a
17
1
11

MONITOR
1005
602
1133
647
Evacuation rate (%)
(safe-a / total-pop-at-risk) * 100
1
1
11

CHOOSER
368
608
506
653
td-behavior
td-behavior
"Deterministic" "Stochastic"
0

PLOT
641
657
1304
996
Bus Stop Passengers
Time (s)
Number of Passengers
0.0
10.0
0.0
10.0
true
true
"" ""
PENS
"Node 276" 1.0 0 -16777216 true "" "plot [pop-here] of node 276"
"Node 277" 1.0 0 -7500403 true "" "plot [pop-here] of node 277"
"Node 278" 1.0 0 -2674135 true "" "plot [pop-here] of node 278"
"Node 279" 1.0 0 -955883 true "" "plot [pop-here] of node 279"
"Node 280" 1.0 0 -6459832 true "" "plot [pop-here] of node 280"
"Node 281" 1.0 0 -1184463 true "" "plot [pop-here] of node 281"
"Node 282" 1.0 0 -10899396 true "" "plot [pop-here] of node 282"
"Node 283" 1.0 0 -13840069 true "" "plot [pop-here] of node 283"
"Node 284" 1.0 0 -14835848 true "" "plot [pop-here] of node 284"
"Node 285" 1.0 0 -11221820 true "" "plot [pop-here] of node 285"
"Node 286" 1.0 0 -13791810 true "" "plot [pop-here] of node 286"
"Node 287" 1.0 0 -13345367 true "" "plot [pop-here] of node 287"
"Node 288" 1.0 0 -8630108 true "" "plot [pop-here] of node 288"
"Node 289" 1.0 0 -5825686 true "" "plot [pop-here] of node 289"
"Node 290" 1.0 0 -2064490 true "" "plot [pop-here] of node 290"
"Node 291" 1.0 0 -1002062 true "" "plot [pop-here] of node 291"
"Node 292" 1.0 0 -3773024 true "" "plot [pop-here] of node 292"
"Node 293" 1.0 0 -13734290 true "" "plot [pop-here] of node 293"
"Node 294" 1.0 0 -13688555 true "" "plot [pop-here] of node 294"

@#$#@#$#@
## THINGS TO IMPROVE


## WHAT IS IT?

(a general understanding of what the model is trying to show or explain)

## HOW IT WORKS

(what rules the agents use to create the overall behavior of the model)

## HOW TO USE IT

(how to use the model, including a description of each of the items in the Interface tab)

## THINGS TO NOTICE

(suggested things for the user to notice while running the model)

## THINGS TO TRY

(suggested things for the user to try to do (move sliders, switches, etc.) with the model)

## EXTENDING THE MODEL

(suggested things to add or change in the Code tab to make the model more complicated, detailed, accurate, etc.)

## NETLOGO FEATURES

(interesting or unusual features of NetLogo that the model uses, particularly in the Code tab; or where workarounds were needed for missing features)

## RELATED MODELS

(models in the NetLogo Models Library and elsewhere which are of related interest)

## CREDITS AND REFERENCES

(a reference to the model's URL on the web if it has one, as well as any other necessary credits, citations, and links)
@#$#@#$#@
default
true
0
Polygon -7500403 true true 150 5 40 250 150 205 260 250

airplane
true
0
Polygon -7500403 true true 150 0 135 15 120 60 120 105 15 165 15 195 120 180 135 240 105 270 120 285 150 270 180 285 210 270 165 240 180 180 285 195 285 165 180 105 180 60 165 15

arrow
true
0
Polygon -7500403 true true 150 0 0 150 105 150 105 293 195 293 195 150 300 150

box
false
0
Polygon -7500403 true true 150 285 285 225 285 75 150 135
Polygon -7500403 true true 150 135 15 75 150 15 285 75
Polygon -7500403 true true 15 75 15 225 150 285 150 135
Line -16777216 false 150 285 150 135
Line -16777216 false 150 135 15 75
Line -16777216 false 150 135 285 75

bug
true
0
Circle -7500403 true true 96 182 108
Circle -7500403 true true 110 127 80
Circle -7500403 true true 110 75 80
Line -7500403 true 150 100 80 30
Line -7500403 true 150 100 220 30

bus
false
0
Polygon -7500403 true true 15 206 15 150 15 120 30 105 270 105 285 120 285 135 285 206 270 210 30 210
Rectangle -16777216 true false 36 126 231 159
Line -7500403 false 60 135 60 165
Line -7500403 false 60 120 60 165
Line -7500403 false 90 120 90 165
Line -7500403 false 120 120 120 165
Line -7500403 false 150 120 150 165
Line -7500403 false 180 120 180 165
Line -7500403 false 210 120 210 165
Line -7500403 false 240 135 240 165
Rectangle -16777216 true false 15 174 285 182
Circle -16777216 true false 48 187 42
Rectangle -16777216 true false 240 127 276 205
Circle -16777216 true false 195 187 42
Line -7500403 false 257 120 257 207

butterfly
true
0
Polygon -7500403 true true 150 165 209 199 225 225 225 255 195 270 165 255 150 240
Polygon -7500403 true true 150 165 89 198 75 225 75 255 105 270 135 255 150 240
Polygon -7500403 true true 139 148 100 105 55 90 25 90 10 105 10 135 25 180 40 195 85 194 139 163
Polygon -7500403 true true 162 150 200 105 245 90 275 90 290 105 290 135 275 180 260 195 215 195 162 165
Polygon -16777216 true false 150 255 135 225 120 150 135 120 150 105 165 120 180 150 165 225
Circle -16777216 true false 135 90 30
Line -16777216 false 150 105 195 60
Line -16777216 false 150 105 105 60

car
false
0
Polygon -7500403 true true 300 180 279 164 261 144 240 135 226 132 213 106 203 84 185 63 159 50 135 50 75 60 0 150 0 165 0 225 300 225 300 180
Circle -16777216 true false 180 180 90
Circle -16777216 true false 30 180 90
Polygon -16777216 true false 162 80 132 78 134 135 209 135 194 105 189 96 180 89
Circle -7500403 true true 47 195 58
Circle -7500403 true true 195 195 58

circle
false
0
Circle -7500403 true true 0 0 300

circle 2
false
0
Circle -7500403 true true 0 0 300
Circle -16777216 true false 30 30 240

cow
false
0
Polygon -7500403 true true 200 193 197 249 179 249 177 196 166 187 140 189 93 191 78 179 72 211 49 209 48 181 37 149 25 120 25 89 45 72 103 84 179 75 198 76 252 64 272 81 293 103 285 121 255 121 242 118 224 167
Polygon -7500403 true true 73 210 86 251 62 249 48 208
Polygon -7500403 true true 25 114 16 195 9 204 23 213 25 200 39 123

cylinder
false
0
Circle -7500403 true true 0 0 300

dot
false
0
Circle -7500403 true true 90 90 120

face happy
false
0
Circle -7500403 true true 8 8 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Polygon -16777216 true false 150 255 90 239 62 213 47 191 67 179 90 203 109 218 150 225 192 218 210 203 227 181 251 194 236 217 212 240

face neutral
false
0
Circle -7500403 true true 8 7 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Rectangle -16777216 true false 60 195 240 225

face sad
false
0
Circle -7500403 true true 8 8 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Polygon -16777216 true false 150 168 90 184 62 210 47 232 67 244 90 220 109 205 150 198 192 205 210 220 227 242 251 229 236 206 212 183

fish
false
0
Polygon -1 true false 44 131 21 87 15 86 0 120 15 150 0 180 13 214 20 212 45 166
Polygon -1 true false 135 195 119 235 95 218 76 210 46 204 60 165
Polygon -1 true false 75 45 83 77 71 103 86 114 166 78 135 60
Polygon -7500403 true true 30 136 151 77 226 81 280 119 292 146 292 160 287 170 270 195 195 210 151 212 30 166
Circle -16777216 true false 215 106 30

flag
false
0
Rectangle -7500403 true true 60 15 75 300
Polygon -7500403 true true 90 150 270 90 90 30
Line -7500403 true 75 135 90 135
Line -7500403 true 75 45 90 45

flower
false
0
Polygon -10899396 true false 135 120 165 165 180 210 180 240 150 300 165 300 195 240 195 195 165 135
Circle -7500403 true true 85 132 38
Circle -7500403 true true 130 147 38
Circle -7500403 true true 192 85 38
Circle -7500403 true true 85 40 38
Circle -7500403 true true 177 40 38
Circle -7500403 true true 177 132 38
Circle -7500403 true true 70 85 38
Circle -7500403 true true 130 25 38
Circle -7500403 true true 96 51 108
Circle -16777216 true false 113 68 74
Polygon -10899396 true false 189 233 219 188 249 173 279 188 234 218
Polygon -10899396 true false 180 255 150 210 105 210 75 240 135 240

house
false
0
Rectangle -7500403 true true 45 120 255 285
Rectangle -16777216 true false 120 210 180 285
Polygon -7500403 true true 15 120 150 15 285 120
Line -16777216 false 30 120 270 120

leaf
false
0
Polygon -7500403 true true 150 210 135 195 120 210 60 210 30 195 60 180 60 165 15 135 30 120 15 105 40 104 45 90 60 90 90 105 105 120 120 120 105 60 120 60 135 30 150 15 165 30 180 60 195 60 180 120 195 120 210 105 240 90 255 90 263 104 285 105 270 120 285 135 240 165 240 180 270 195 240 210 180 210 165 195
Polygon -7500403 true true 135 195 135 240 120 255 105 255 105 285 135 285 165 240 165 195

line
true
0
Line -7500403 true 150 0 150 300

line half
true
0
Line -7500403 true 150 0 150 150

pentagon
false
0
Polygon -7500403 true true 150 15 15 120 60 285 240 285 285 120

person
false
0
Circle -7500403 true true 110 5 80
Polygon -7500403 true true 105 90 120 195 90 285 105 300 135 300 150 225 165 300 195 300 210 285 180 195 195 90
Rectangle -7500403 true true 127 79 172 94
Polygon -7500403 true true 195 90 240 150 225 180 165 105
Polygon -7500403 true true 105 90 60 150 75 180 135 105

plant
false
0
Rectangle -7500403 true true 135 90 165 300
Polygon -7500403 true true 135 255 90 210 45 195 75 255 135 285
Polygon -7500403 true true 165 255 210 210 255 195 225 255 165 285
Polygon -7500403 true true 135 180 90 135 45 120 75 180 135 210
Polygon -7500403 true true 165 180 165 210 225 180 255 120 210 135
Polygon -7500403 true true 135 105 90 60 45 45 75 105 135 135
Polygon -7500403 true true 165 105 165 135 225 105 255 45 210 60
Polygon -7500403 true true 135 90 120 45 150 15 180 45 165 90

sheep
false
15
Circle -1 true true 203 65 88
Circle -1 true true 70 65 162
Circle -1 true true 150 105 120
Polygon -7500403 true false 218 120 240 165 255 165 278 120
Circle -7500403 true false 214 72 67
Rectangle -1 true true 164 223 179 298
Polygon -1 true true 45 285 30 285 30 240 15 195 45 210
Circle -1 true true 3 83 150
Rectangle -1 true true 65 221 80 296
Polygon -1 true true 195 285 210 285 210 240 240 210 195 210
Polygon -7500403 true false 276 85 285 105 302 99 294 83
Polygon -7500403 true false 219 85 210 105 193 99 201 83

square
false
0
Rectangle -7500403 true true 30 30 270 270

square 2
false
0
Rectangle -7500403 true true 30 30 270 270
Rectangle -16777216 true false 60 60 240 240

star
false
0
Polygon -7500403 true true 151 1 185 108 298 108 207 175 242 282 151 216 59 282 94 175 3 108 116 108

target
false
0
Circle -7500403 true true 0 0 300
Circle -16777216 true false 30 30 240
Circle -7500403 true true 60 60 180
Circle -16777216 true false 90 90 120
Circle -7500403 true true 120 120 60

tree
false
0
Circle -7500403 true true 118 3 94
Rectangle -6459832 true false 120 195 180 300
Circle -7500403 true true 65 21 108
Circle -7500403 true true 116 41 127
Circle -7500403 true true 45 90 120
Circle -7500403 true true 104 74 152

triangle
false
0
Polygon -7500403 true true 150 30 15 255 285 255

triangle 2
false
0
Polygon -7500403 true true 150 30 15 255 285 255
Polygon -16777216 true false 151 99 225 223 75 224

truck
false
0
Rectangle -7500403 true true 4 45 195 187
Polygon -7500403 true true 296 193 296 150 259 134 244 104 208 104 207 194
Rectangle -1 true false 195 60 195 105
Polygon -16777216 true false 238 112 252 141 219 141 218 112
Circle -16777216 true false 234 174 42
Rectangle -7500403 true true 181 185 214 194
Circle -16777216 true false 144 174 42
Circle -16777216 true false 24 174 42
Circle -7500403 false true 24 174 42
Circle -7500403 false true 144 174 42
Circle -7500403 false true 234 174 42

turtle
true
0
Polygon -10899396 true false 215 204 240 233 246 254 228 266 215 252 193 210
Polygon -10899396 true false 195 90 225 75 245 75 260 89 269 108 261 124 240 105 225 105 210 105
Polygon -10899396 true false 105 90 75 75 55 75 40 89 31 108 39 124 60 105 75 105 90 105
Polygon -10899396 true false 132 85 134 64 107 51 108 17 150 2 192 18 192 52 169 65 172 87
Polygon -10899396 true false 85 204 60 233 54 254 72 266 85 252 107 210
Polygon -7500403 true true 119 75 179 75 209 101 224 135 220 225 175 261 128 261 81 224 74 135 88 99

wheel
false
0
Circle -7500403 true true 3 3 294
Circle -16777216 true false 30 30 240
Line -7500403 true 150 285 150 15
Line -7500403 true 15 150 285 150
Circle -7500403 true true 120 120 60
Line -7500403 true 216 40 79 269
Line -7500403 true 40 84 269 221
Line -7500403 true 40 216 269 79
Line -7500403 true 84 40 221 269

wolf
false
0
Polygon -16777216 true false 253 133 245 131 245 133
Polygon -7500403 true true 2 194 13 197 30 191 38 193 38 205 20 226 20 257 27 265 38 266 40 260 31 253 31 230 60 206 68 198 75 209 66 228 65 243 82 261 84 268 100 267 103 261 77 239 79 231 100 207 98 196 119 201 143 202 160 195 166 210 172 213 173 238 167 251 160 248 154 265 169 264 178 247 186 240 198 260 200 271 217 271 219 262 207 258 195 230 192 198 210 184 227 164 242 144 259 145 284 151 277 141 293 140 299 134 297 127 273 119 270 105
Polygon -7500403 true true -1 195 14 180 36 166 40 153 53 140 82 131 134 133 159 126 188 115 227 108 236 102 238 98 268 86 269 92 281 87 269 103 269 113

x
false
0
Polygon -7500403 true true 270 75 225 30 30 225 75 270
Polygon -7500403 true true 30 75 75 30 270 225 225 270
@#$#@#$#@
NetLogo 6.4.0
@#$#@#$#@
@#$#@#$#@
@#$#@#$#@
<experiments>
  <experiment name="experiment" repetitions="100" runMetricsEveryStep="true">
    <setup>setup
import-agent-paths</setup>
    <go>go</go>
    <metric>safe-a</metric>
    <metric>safe-r</metric>
    <metric>safe-t</metric>
    <enumeratedValueSet variable="num-buses">
      <value value="5"/>
      <value value="10"/>
      <value value="15"/>
      <value value="20"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="bus-capacity">
      <value value="40"/>
      <value value="60"/>
      <value value="80"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="departure-mean">
      <value value="45"/>
      <value value="120"/>
      <value value="360"/>
      <value value="600"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="bus-wait-time">
      <value value="2"/>
      <value value="5"/>
      <value value="10"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="td-behavior">
      <value value="&quot;Deterministic&quot;"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="tsunami-arrival-time">
      <value value="840"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="no-of-tourists">
      <value value="4647"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="seed?">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="create-paths?">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="bus-strategy">
      <value value="&quot;far to close&quot;"/>
      <value value="&quot;close to far&quot;"/>
    </enumeratedValueSet>
  </experiment>
  <experiment name="experiment2" repetitions="100" runMetricsEveryStep="true">
    <setup>setup
import-agent-paths</setup>
    <go>go</go>
    <metric>safe-a</metric>
    <metric>safe-r</metric>
    <metric>safe-t</metric>
    <enumeratedValueSet variable="num-buses">
      <value value="5"/>
      <value value="10"/>
      <value value="15"/>
      <value value="20"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="bus-capacity">
      <value value="40"/>
      <value value="60"/>
      <value value="80"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="departure-mean">
      <value value="45"/>
      <value value="120"/>
      <value value="360"/>
      <value value="600"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="bus-wait-time">
      <value value="2"/>
      <value value="5"/>
      <value value="10"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="td-behavior">
      <value value="&quot;Deterministic&quot;"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="tsunami-arrival-time">
      <value value="840"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="no-of-tourists">
      <value value="18586"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="seed?">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="create-paths?">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="bus-strategy">
      <value value="&quot;far to close&quot;"/>
      <value value="&quot;close to far&quot;"/>
    </enumeratedValueSet>
  </experiment>
</experiments>
@#$#@#$#@
@#$#@#$#@
default
0.0
-0.2 0 0.0 1.0
0.0 1 1.0 0.0
0.2 0 0.0 1.0
link direction
true
0
Line -7500403 true 150 150 90 180
Line -7500403 true 150 150 210 180
@#$#@#$#@
0
@#$#@#$#@
