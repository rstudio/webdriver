
context("utils")

test_that("can unbox a list", {
  test_list <- list(a = list(c = "un_box2", 
                        d = list(e = c("boxed2", "boxed3")
                                 ,f = I("boxed1"), g = "un_box3")
  )
  , b = "un_box1", h = unbox("un_box4"))
  jl_output <- toJSON(test_list, auto_unbox = TRUE)
  ul_output <- toJSON(unbox_list(test_list))
  expect_identical(ul_output, jl_output)
})
  