package dk.sdu.imada;

public class Main {

    public static void main(String[] args) {
        NumberCalculations numberCalculations = new NumberCalculations();
        for(int i = 0; i < 41; i++) {
            try {
                System.out.println("Fibonnacci number: " + i + "=" + numberCalculations.calculateFibonnacci(i));
            } catch(InputException ie) {
                System.out.println(ie.getMessage());
            }
        }
    }
}
