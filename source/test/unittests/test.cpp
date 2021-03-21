/*  test/unittests/test.cpp
 *
 *  Copyright (c) 2021 Mitya Selivanov
 *
 *  This file is part of the cxx-project.
 */

#include "../../cxx-project/core/core.h"
#include <gtest/gtest.h>

namespace yetanotherproject {
  TEST(cxx_project, some_test) {
    
    EXPECT_EQ(get_value(), 42);
  }
}
