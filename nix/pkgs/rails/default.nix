{ ruby }:

ruby.withPackages (ps: with ps; [ rails puma ])
