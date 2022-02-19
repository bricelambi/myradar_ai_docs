#!/bin/bash

out_dir=/home/ps/fcst_data/frost_control/tmp

pandoc -o ${out_dir}/single.html single.md --template=easy_template.html
pandoc -o ${out_dir}/route.html route.md --template=easy_template.html
pandoc -o ${out_dir}/power.html power.md --template=easy_template.html
pandoc -o ${out_dir}/hist.html hist.md --template=easy_template.html
pandoc -o ${out_dir}/anim.html animation.md --template=easy_template.html
pandoc -o ${out_dir}/endpoints.html endpoints.md --template=easy_template.html

cp Native_Load_2021.csv power.png 2d.png hist.png route.png single.png ${out_dir}

