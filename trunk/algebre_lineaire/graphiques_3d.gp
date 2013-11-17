set term pdf
set key off
set parametric
set xyplane relative 0

set view 70, 15

set output "unique_3d.pdf"
splot [0:1] [0:1]   [0:1] [0:1] [0:1]  u,v,0.5,  u,0.5,v,   0.5,u,v
set output

set output "aucune_3d.pdf"
splot [0:1] [0:1]   [0:1] [0:1] [0:1]  u,v,0.25,  u,v,0.5,   u,v,0.75
set output

set output "infinite_3d.pdf"
splot [0:1] [0:1]   [0:1] [0:1] [0:1]  u,v,0.75,  u,v,0.25,   u,v,u
set output
