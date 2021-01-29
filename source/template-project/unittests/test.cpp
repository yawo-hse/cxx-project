#include "../core/core.h"
#include <gtest/gtest.h>

TEST(template_project, some_test) {
  using namespace yetanotherproject;
  
  EXPECT_EQ(get_value(), 42);
}
