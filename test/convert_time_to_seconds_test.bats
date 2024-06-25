setup() {
  load 'test_helper/bats-assert/load'

  # get the containing directory of this file
  # use $BATS_TEST_FILENAME instead of ${BASH_SOURCE[0]} or $0,
  # as those will point to the bats executable's location or the preprocessed file respectively
  DIR="$(cd "$(dirname "$BATS_TEST_FILENAME")" >/dev/null 2>&1 && pwd)"

  # make executables in src/ visible to PATH
  PATH="$DIR/../src:$PATH"
}

@test "converts '1 minute' to seconds" {
  run convert_time_to_seconds.sh '1 minute'
  assert_output 60
}

@test "converts '2 minutes' to seconds" {
  run convert_time_to_seconds.sh '2 minutes'
  assert_output 120
}

@test "converts '1 hour' to seconds" {
  run convert_time_to_seconds.sh '1 hour'
  assert_output 3600
}

@test "converts '3 hours' to seconds" {
  run convert_time_to_seconds.sh '3 hours'
  assert_output 10800
}

@test "converts '1 day' to seconds" {
  run convert_time_to_seconds.sh '1 day'
  assert_output 86400
}

@test "converts '4 days' to seconds" {
  run convert_time_to_seconds.sh '4 days'
  assert_output 345600
}

@test "converts '5.5 days' to seconds" {
  run convert_time_to_seconds.sh '5.5 days'
  assert_output 475200
}

@test "converts '1 week' to seconds" {
  run convert_time_to_seconds.sh '1 week'
  assert_output 604800
}

@test "converts '3 weeks' to seconds" {
  run convert_time_to_seconds.sh '3 weeks'
  assert_output 1814400
}
