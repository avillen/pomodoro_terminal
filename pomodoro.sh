#!/bin/bash
# vim: ai:ts=8:sw=8:noet


################################################################################
# Prints a help
#
help() {
  echo "Usage: $0"
  echo "  -n <number-of-pomodoros>"
  echo "  -d <duration-of-each-pomodoro>"
  echo "  -s <duration-short-break>"

  exit 1
}


################################################################################
# Notify
#
# Input:
# $1 - message
#
notify() {
   say $1
   echo $1
}


################################################################################
# Run the pomodoro
#
# Input:
# $1 - NUMBER_OF_POMODOROS
# $2 - DURATION_EACH_POMODORO
# $3 - DURATION_SHORT_BREAK
#
run() {
  local number_of_pomodoros="$1"
  local duration_each_pomodoro="$2"
  local duration_short_break="$3"

  for pomodoro in `seq 1 $number_of_pomodoros`
  do
   notify "Pomodoro número $pomodoro"

   sleep "$duration_each_pomodoro"

   notify "Descansito!"

   sleep "$duration_short_break"
  done
}


################################################################################
# Main
#
main() {
  MULT_MIN=60
  # Default values
  n=5
  d=25
  s=5

  while getopts ":n:d:s" o; do
    case "${o}" in
      n)
        n="${OPTARG:-$n}"
        ;;
      d)
        d="${OPTARG:-$d}"
        ;;
      s)
        s="${OPTARG:-$s}"
        ;;
      *)
        help
        ;;
    esac
  done
  shift $((OPTIND-1))

  NUMBER_OF_POMODOROS="$(($n * $MULT_MIN))"
  DURATION_EACH_POMODORO="$(($d * $MULT_MIN))"
  DURATION_SHORT_BREAK="$(($s * $MULT_MIN))"

  run "$NUMBER_OF_POMODOROS" "$DURATION_EACH_POMODORO" "$DURATION_SHORT_BREAK"
}

main "$@"

