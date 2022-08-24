source_robot_folders() {
  unalias fzirob
  unalias ce
  source /home/max/Work/FZI/robot_folders/bin/fzirob_source.sh
  $@
}

setup_anymal() {
  export ROS_IP=192.168.151.69
  export ROS_MASTER_URI=http://192.168.151.51:11311
}

setup_anymal_wifi() {
  sudo ip route add 192.168.151.0/24 via 192.168.42.151 dev wlp0s20f3
}

