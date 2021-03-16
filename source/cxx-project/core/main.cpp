/*  cxx-project/core/main.cpp
 *
 *  Copyright (c) 2021 Mitya Selivanov
 *
 *  This file is part of the cxx-project.
 *
 *  Laplace is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty
 *  of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See
 *  the MIT License for more details.
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
