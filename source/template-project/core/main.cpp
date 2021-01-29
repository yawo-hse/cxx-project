#include "core.h"
#include <gtest/gtest.h>

auto yetanotherproject::get_value() -> int {
  return 42;
}

auto main() -> int {
  testing::InitGoogleTest();
  return RUN_ALL_TESTS();
}
