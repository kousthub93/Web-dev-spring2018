defmodule Calc do
  @moduledoc """
  Documentation for Calc.
  """

  @doc """
  Hello world.

  ## Examples

  """
  

 def findValue(num1,num2,op) do
    
    {finalNum1,_} = Integer.parse(num1)
    {finalNum2,_} = Integer.parse(num2)
    res = 0
    cond do

      op == "+" ->

         res = finalNum1 + finalNum2
         finalRes = to_string(res)

      op == "*" ->

         res=finalNum1 * finalNum2
         finalRes = to_string(res)

      op == "/" ->

         res= div(finalNum1,finalNum2)
         finalRes = to_string(res)

      op == "-" ->

         res=finalNum1 - finalNum2
         finalRes = to_string(res)
         finalRes

    end

 end

 def evalParan(valueStack,opStack) do

    opHead = hd(opStack)
    opTail = tl(opStack)
    res =0
    if(!(String.contains? opHead,"(")) do

      if((length valueStack)!= 0)  do

        {val1,remStack1} = List.pop_at(valueStack,0)

        {val2,remStack2} = List.pop_at(remStack1,0)
          

       res =  findValue(val2,val1,opHead)

       finalValueStack = [res]++remStack2

       evalParan(finalValueStack,opTail)

      end

      else

       {_,finalOpStack} = List.pop_at(opStack,0)

       result = [valueStack] ++ [finalOpStack]

       result

    end

  end


  def pushLeftParan(stackOperator,eachExp) do

    stackOperator = [eachExp]++stackOperator
    stackOperator

  end

  # pop two operands and one operator and evaluate 
  def doArithOp(stackOperand,stackOperator,eachExp) do

    operator = hd(stackOperator)

    stackOperator = tl(stackOperator)

    num1 = hd(stackOperand)
    stackOperand = tl(stackOperand)
    num2 = hd(stackOperand)
    stackOperand = tl(stackOperand)
    res = findValue(num2,num1,operator)
    stackOperand = [res] ++ stackOperand
    stackOperator = [eachExp] ++ stackOperator

    finalRes = [stackOperand] ++ [stackOperator]
    finalRes

  end


  # this is the function to get the final value
  def extractFinalValue(stackOperand,stackOperator) do

    if((length stackOperator) != 0) do

      operator = hd(stackOperator)
      stackOperator = tl(stackOperator)
      num1 = hd(stackOperand)
      stackOperand = tl(stackOperand)
      num2 = hd(stackOperand)
      stackOperand = tl(stackOperand)
      res = findValue(num2,num1,operator)
      stackOperand = [res]++stackOperand
      extractFinalValue(stackOperand,stackOperator)

    else

      {evaluatedValue,_} = Integer.parse(hd(stackOperand))
      evaluatedValue

    end

  end

  # convert to infix to postfix and evaluate
  def evaluatePostFix(stackOperand,stackOperator,expList) do

    if((length expList) != 0) do

      eachExp = hd(expList) # get the first element in the expression list

      if(Regex.match?(~r/^-*[0-9]+$/, eachExp)) do  # this matches only integers

        stackOperand = [eachExp]++stackOperand  # push integer into the operand stack

      else 

        if((length stackOperator) == 0) do

          stackOperator = [eachExp]++stackOperator # push operator into the stack

        else

          cond do # check whether its an integer or an operator

            String.contains? eachExp,"(" -> # is its "(", push into stack

              stackOperator = pushLeftParan(stackOperator,eachExp)

            String.contains? eachExp,")" -> # keep popping and evaluate until "("

              res = evalParan(stackOperand, stackOperator)   
              {res1,_} = List.pop_at(res,0) # since res is a list of list
              stackOperand = res1
              {res2,_} = List.pop_at(res,1)
              stackOperator = res2 

            eachExp == "+" || eachExp == "-" ->

              if(hd(stackOperator) == "(") do

                stackOperator = [eachExp] ++ stackOperator

              else 

                # res is a list of list containing both the stacks
                res = doArithOp(stackOperand,stackOperator,eachExp)
                {res1,_} = List.pop_at(res,0)
                stackOperand = res1
                {res2,_} = List.pop_at(res,1)
                stackOperator = res2

              end

            # check precedence, if low,then pop else push to the stack
            eachExp == "*" || eachExp == "/" ->

              head = hd(stackOperator)
              if(head == "+" || head == "-" || head == "(") do

                stackOperator = [eachExp]++stackOperator

              else

                res = doArithOp(stackOperand,stackOperator,eachExp)
                {res1,_} = List.pop_at(res,0)
                stackOperand = res1
                {res2,_} = List.pop_at(res,1)
                stackOperator = res2

              end
              
          end

        end

      end

      newExpList = tl(expList) # recurse the function with the expression list

      # calling reccursively
      evaluatePostFix(stackOperand,stackOperator,newExpList) 

      else

        finalEvaluatedValue = extractFinalValue(stackOperand,stackOperator)
        finalEvaluatedValue
    end

  end

  def eval(expression) do

    stackOperand = []
    stackOperator = []
    expression = Regex.replace(~r/\(/, expression, "( ")
    expression = Regex.replace(~r/\)/, expression, " )")
    expList = String.split(expression)

    #start evaluating after converting expression to a list
    finalEvaluatedValue =  evaluatePostFix(stackOperand,stackOperator,expList)
    finalEvaluatedValue

  end
  
  def main() do 

    IO.gets("Please enter the expression to be evaluated\n")
    |> eval() |> IO.puts 

    main()
  end

end