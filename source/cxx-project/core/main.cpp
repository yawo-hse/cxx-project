/*  cxx-project/core/main.cpp
 *
 *  Copyright (c) 2021 Mitya Selivanov
 *
 *  This file is part of the cxx-project.
 */

#include "core.h"
#include <gtest/gtest.h>

auto yetanotherproject::get_value() noexcept -> int {
  return 42;
}

auto main() -> int {
  testing::InitGoogleTest();
  return RUN_ALL_TESTS();
}
