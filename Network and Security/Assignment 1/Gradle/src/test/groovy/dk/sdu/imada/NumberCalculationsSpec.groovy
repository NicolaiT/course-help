package dk.sdu.imada

import spock.lang.Ignore
import spock.lang.Specification
import spock.lang.Unroll

class NumberCalculationsSpec extends Specification {

    void "Check exception is thrown for 0 input"() {
        setup:
        NumberCalculations numberCalculations = new NumberCalculations()

        when:
        numberCalculations.calculateFibonnacci(0)

        then:
        def e = thrown(InputException)
        e.message == "Input must be >= 1"
    }

    @Unroll
    void "Check the first two fibbonnacci numbers are 1"() {
        setup:
        NumberCalculations numberCalculations = new NumberCalculations()

        expect:
        numberCalculations.calculateFibonnacci(number) == 1

        where:
        number << [1,2]
    }

    void "Check the third fibbonnacci number is 2"() {
        expect:
        new NumberCalculations().calculateFibonnacci(3) == 2
    }

    @Unroll
    void "Check some of the bigger numbers in fibbonnacci sequence fib(#number)=#result"() {
        expect:
        new NumberCalculations().calculateFibonnacci(number) == result

        where:
        number          | result
        15              | 610
        20              | 6765
        25              | 75025
    }

    void "This test should be updated with the result for your assignment"() {
        expect:
        new NumberCalculations().calculateFibonnacci(40) == 102334155 // "Replace 0 with the result for your assignment to make the test pass"
    }

    //@Ignore // Remove this for the extra challenge - you need to remember the results (dynamic programming)
    void "Check a quite large fibonnacci number"() {
        expect:
        new NumberCalculations().calculateFibonnacci(500) == 139423224561697880139724382870407283950070256587697307264108962948325571622863290691557658876222521294125
    }
}
