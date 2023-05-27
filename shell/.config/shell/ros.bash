source_robot_folders() {
  unalias fzirob
  unalias ce
  source /home/max/work/fzi/robot_folders/bin/fzirob_source.sh
  $@
}

setup_anymal() {
  export ROS_IP=192.168.42.166
  export ROS_MASTER_URI=http://192.168.151.51:11311
}

setup_spot() {
  export ROS_IP=192.168.50.5
  export ROS_MASTER_URI=http://192.168.42.141:11311
}

setup_anymal_wifi() {
  sudo ip route add 192.168.151.0/24 via 192.168.42.151 dev wlp0s20f3
}

setup_base_station() {
  export ROS_IP=192.168.42.190
  export ROS_MASTER_URI=http://192.168.42.42:11311
}

setup_husky_biobots() {
  source ~/current_semester/biobots/simulation_ws/devel/setup.zsh
  export ROS_MASTER_URI=http://ids-husky-01:11311
  export ROS_IP=192.168.42.166
}

link_compile_commands() {
  ws_root="$(echo $CMAKE_PREFIX_PATH | cut --delimiter=':' --fields=1 | xargs dirname)"
  package_name="$(pwd | xargs basename)"
  compile_commands_path="$ws_root"/build/"$package_name"/compile_commands.json

  ln -s "$compile_commands_path" ./compile_commands.json

}
