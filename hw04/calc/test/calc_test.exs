defmodule CalcTest do
  use ExUnit.Case
  doctest Calc

  test "simpleExpression1" do
    assert Calc.eval("12 + 4 + 9") == 25
  end

  test "simpleExpression2" do
    assert Calc.eval("12 + (4 + 9)") == 25
  end

  test "simpleExpression3" do
    assert Calc.eval("90 / 9 / 2") == 5
  end

  test "simpleExpression4" do
    assert Calc.eval("90 / 9 / -2") == -5
  end

  test "simpleExpression5" do
    assert Calc.eval("90 / 9 / -2") == -5
  end

  test "simpleExpression6" do
    assert Calc.eval("(2 * -2 ) / (3 * 6)") == 0
  end

  test "simpleExpression7" do
    assert Calc.eval("(2 + -2 * (12 / -3) ) / (3 * 6)") == 0
  end

  test "simpleExpression8" do
    assert Calc.eval("(-1 * (12 / -3) ) / (3 * 6)") == 0
  end

  test "simpleExpression9" do
    assert Calc.eval("( 2 * 3 ) / 2 + 8") == 11
  end

  test "simpleExpression10" do
    assert Calc.eval("(20 * -2 / (-2 * 3))") == 6
  end

end
