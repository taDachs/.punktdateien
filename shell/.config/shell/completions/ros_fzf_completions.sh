# Stolen from https://github.com/fmauch/dot_profile/blob/master/.profile_plugins/fzf_completions.sh
_fzf_complete_rostopic() {
  ARGS="$@"
  _fzf_complete "--sort" "$@" < <(
  { rostopic list }
  )
}
_fzf_complete_rosnode() {
  ARGS="$@"
  _fzf_complete "--sort" "$@" < <(
  { rosnode list }
  )
}
_fzf_complete_rosservice() {
  ARGS="$@"
  _fzf_complete "--sort" "$@" < <(
  { rosservice list }
  )
}
_fzf_complete_rosparam() {
  ARGS="$@"
  _fzf_complete "--sort" "$@" < <(
  { rosparam list }
  )
}
_fzf_complete_roslaunch() {
  ARGS="$@"
  _fzf_complete "--sort" "$@" < <(
  { rospack list-names }
  )
}
_fzf_complete_rosrun() {
  ARGS="$@"
  _fzf_complete "--sort" "$@" < <(
  { rospack list-names }
  )
}
_fzf_complete_rossrv() {
  ARGS="$@"
  _fzf_complete "--sort" "$@" < <(
  { rossrv list }
  )
}
_fzf_complete_rosmsg() {
  ARGS="$@"
  _fzf_complete "--sort" "$@" < <(
  { rosmsg list }
  )
}
_fzf_complete_roscd() {
  ARGS="$@"
  _fzf_complete "--sort" "$@" < <(
  { rospack list-names }
  )
}
_fzf_complete_ros2_topic_echo() {
  ARGS="$@"
  _fzf_complete "--sort" "$@" < <(
  { ros2 topic list }
  )
}
