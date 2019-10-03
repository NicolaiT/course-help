package dk.sdu.imada;

import java.math.BigInteger;

public class NumberCalculations {

    BigInteger calculateFibonnacci(Integer number) throws InputException {
    	BigInteger previousFibonnacci = BigInteger.ZERO;
    	BigInteger nextFibonnacci = BigInteger.ONE;
    	BigInteger result = BigInteger.ONE;

    	if (number < 1) {
    		throw new InputException("Input must be >= 1");
    	} else {
    		for(int i = 1; i < number; i++) {
	    		result = previousFibonnacci.add(nextFibonnacci);
	    		previousFibonnacci = nextFibonnacci;
	    		nextFibonnacci = result;
    		}
    	}

        return result;
    }
}
