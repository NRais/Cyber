import ecs100.UI;
import ecs100.UIFileChooser;
//import org.apache.commons.collections4.iterators.PermutationIterator;

import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.nio.file.Path;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Scanner;
import java.util.stream.Stream;


public class Cybr_Hash_Gui {

    /**
     *  MAIN METHOD THAT DOES THE HASHING
     */
    public void finalHash() {

        UI.println("... hashing " + guessedPassword.size());

        // for every "guessedPassword" in our arraylist
        for (String i : guessedPassword) {

            // when we are using salt (!= 0)
            if (saltCode.size() != 0) {

                // iterate through and check all our salt values
                for (String salt : saltCode) {

                    byte[] saltB = salt.getBytes(StandardCharsets.UTF_8);

                    runHashing(i , saltB);

                }
            }
            // if we aren't using salt don't bother
            else {
                byte[] saltB = new byte[0]; // pass an empty byte array

                runHashing(i, saltB);
            }


        }

        UI.println("HASHING COMPLETE");
    }

    public void runHashing(String i, byte[] salt) {
        // take our hash code and turn it into a string
        String str = bytesToHex(hash(i, salt));

        // we have a special boolean only for kate which ignores all the rest of the hashes
        if (ONLY_KATE) {
            // for kate
            if (str.contains(onlyKate[0])) {
                UI.println("Answer: " + i + " | " + str);
            }
        }
        // otherwise if not kate
        else {
            // for all our hashes to check
            for (String hash : CHECK) {
                if (str.contains(hash)) {
                    UI.println("Answer: " + i + " | " + str);
                }
            }
        }
    }

    // our arrays of constants
    static final String[] SYMBOLS = new String[] {"!", "@", "#", "$"};

    static final String[] NUMBERS = new String[] {"0" , "1", "2", "3", "4", "5", "6", "7", "8", "9"};

    static final char[] HEX_ARRAY = "0123456789ABCDEF".toCharArray();

    static final String[] HEX = new String[]     {"0" , "1", "2", "3", "4", "5", "6", "7", "8", "9",
                                            "a", "b", "c", "d", "e", "f"};

    static final String[] LETTERS = new String[] {"a", "b", "c", "d", "e", "f",
                                            "g", "h", "i", "j", "k", "l", "m", "n", "o",
                                            "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z"};


    // 14 users here are there hash codes:
    static final String[] CHECK = new String[]{"0098856EBC696834CEC8D076C1E51EE2D4707C5172CD8EA34D6EED7C93B530A7",
            "EB0615C6636306A1AB164A3EBAAE04F112E5A885FAA27F2C68D38F56245330F8",
            "D5744B6BF140CA2D634C3690B7E2913A75E6B3536908F4D8928927558615A5D1",
            "BC4172206E637F3CBEFE60A98E193A58F5611C4FFDCDE5EA00D297C0890AAC0C",

            "DB40E36F9EA468F330BBBC0B5DCBD7D8E93B66343483E1F6A48D4A78E91AC169",
            "A4A22B18B9DC3B622734E5573C2FF28E2C320FF491C8BE73FB71752026FB41CB",
            "EA0F08ED7ECB2B29A658FA456564EFE9C01B58B8DE83D07F592DEF0857E5DB68",
            "76FD57D1416244A0FBEA3718AD972420B4AF10E9DF73F71E10BB3E1FB1EB2540",
            "BC432D5013D596990BC6EE9E25704B2CE923D34463CCA7DA4860DBE0E8A7C5DD",

            "8D460ED60BB9C91B8FBAEE31322DA62334B9F60DDB6B0180DBEB193667E47CCB",
            "D825E379D8B1BE64DE8BBBB776AFD17D7B3A6C16B9C1149B1F5CFDD93A77FF57",
            "9593193112455DF024A8D7A6A41B01196D509AEC704627A7D0BA0CEE1D7A8AE0",
            "DC84DCB72EC7B6F3BAA104BFF60BFA10B96FB248B33EA1F65BE18A027E0D7906",
            "2B3B2A6C7D2E18BF6BD44A63DA7A24A0F5FDE915907A8FEAAAF6F2F9DFBBDE85"};

    boolean ONLY_KATE = false;
    boolean GUESS_AS_WE_GO = false;
    String[] onlyKate = new String[]{"D825E379D8B1BE64DE8BBBB776AFD17D7B3A6C16B9C1149B1F5CFDD93A77FF57"};

    // key methods to store the passwords and salt we go through
    ArrayList<String> guessedPassword = new ArrayList<>();
    ArrayList<String> saltCode = new ArrayList<>();

    public void showGUI() {

        //UI.addButton("Load Salt", this::salt);
        UI.addButton("Guess words", this::guess);
        UI.addButton("Guess dictionary", this::guessDictionary);
        UI.addButton("Guess Ev", this::guessEverything);
        UI.addButton("Guess NAT", this::addNat);
        UI.addButton("Guess Michaela", this::addMichaela);
        UI.addButton("Guess Liam", this::addLiam);
        UI.addButton("[HASH]", this::finalHash);
        UI.addButton("Clear", this::clear);

        salt(); // auto load salt

    }

    public void clear() {
        UI.clearText();
        //clear
        guessedPassword.removeAll(guessedPassword);
    }

    public void gatherSalt() {
        String input = UI.askString("SALT:");

        // if its a list then add them all
        for (String i : input.split(",")) {
            saltCode.add(i);
        }
    }
    public void salt() {

        // for now load the salt we know we need
        if (!ONLY_KATE) {
            saltCode.add("3Lh7nlv4vw0glpq5");
            saltCode.add("jRsZZaY2fBppefuf");
            saltCode.add("BIOAEb6DLc6RDopT");
            saltCode.add("5YpTZ9kJzk1Mn4xO");
            saltCode.add("4B9iTLSL27THrK0M");
            saltCode.add("9pUOuSMy8g5gosp7");
            saltCode.add("B3W2w9A16ZTC0qKc");
            saltCode.add("F0LGkqngVY2i3WPP");
            saltCode.add("gdDAOlnmLtEeSlhY");
            saltCode.add("rRiTDOYooATVXmdR");
            saltCode.add("piHNbJunE1U1zorO");
            saltCode.add("uIKp9FjJ6QsF6qvS");
            saltCode.add("kojuVmBIvkQCzrXp");
            saltCode.add("uLep9JTiRmM1T9gr");
        } else {
            saltCode.add("piHNbJunE1U1zorO");
        }

        UI.println("LOADED: " + saltCode.get(0) + " to " + saltCode.get(saltCode.size()-1));

    }

    /**
     * guess a single password or list of passwords seperated by commas and no spaces
     */
    public void guess() {

        String input = UI.askString("GUESS:");

        // if its a list then add them all
        for (String i : input.split(",")) {
            addPassword(i);
        }
    }


    /**
     * guess a dictionary file
     */
    public void guessDictionary() {
        try {
            Scanner s = new Scanner(Path.of(UIFileChooser.open()));

            // if its a list then add them all
            while (s.hasNextLine()) {
                addPassword(s.nextLine());
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
        UI.println("Dictionary Loaded");
    }

    /**
     * guess everything of string length X characters
     */
    public void guessEverything() {


        UI.println("(note: letter + num + chars) WARNING for strings longer than 5 chars this will take forever");
        int stringLength = UI.askInt("String length? ");

        ArrayList<String[]> category = new ArrayList<>();

        // for every character count what options we have tried
        for (int i = 0; i < stringLength; i++) {
            category.add(Stream.concat(Stream.concat(Arrays.stream(LETTERS), Arrays.stream(NUMBERS)), Arrays.stream(SYMBOLS)).toArray(String[]::new));
        }

        guessCharSeries(category, stringLength);
    }

    // NOTE: the following three methods are NOT properly optimized to be effective with 6+ characters

    /**
     * guess everything
     * @param letterOptionsEachPosition - try all of these possible chars in each position
     * @param stringLength - for this number of positions
     */
    public void guessCharSeries(ArrayList<String[]> letterOptionsEachPosition, int stringLength) {
        guessCharSeries("", "", letterOptionsEachPosition, stringLength);
    }

    /**
     * guess everything
     * @param startParam - chuck this on the start of our string "HELLO" + EVERY_POSSIBLE_COMBINATION_OF_INTEGERS
     * @param endParam - chuck this on the end of our string EVERY_POSSIBLE_COMBINATION_OF_INTEGERS + "GOODBYE"
     * @param letterOptionsEachPosition - try all of these possible chars in each position
     * @param stringLength - for this number of positions
     */
    public void guessCharSeries(String startParam, String endParam, ArrayList<String[]> letterOptionsEachPosition, int stringLength) {
        // array for how far through our search we have gotten for each char position
        ArrayList<Integer> ints = new ArrayList<>();

        // array of what we should search for in each char position
        ArrayList<String[]> category = letterOptionsEachPosition;

        // for every character count what options we have tried
        for (int i = 0; i < stringLength; i++) {
            ints.add(0);
        }

        boolean going = true;

        while (going) {

            String s = "";

            // for each character get the next character we need and chuck it in
            for (int i = 0; i < stringLength; i++) {
                s = s + category.get(i)[ints.get(i)];
            }

			if (stringLength == s.length()) {
				addPassword(startParam + s + endParam);
			}

            // yay we did something, increment the last item of the array
            int x = stringLength-1; // item to update

            // while the item to update is full (but dont overflow the 0 item)
            while (ints.get(x) >= category.get(x).length-1 && x != 0) {
                // reset the item
                //**System.out.println("Reseting " + x);
                ints.set(x, 0);
                // move to the next item
                x--;
            }
            // then at the end increment something by 1
            //**System.out.println("Updating " + x + " @ " + category.get(x).length);
            ints.set(x, ints.get(x) + 1);

            //**System.out.println("Item: " + x + " " + ints.get(x));

            // when the first character has run its length
            if (ints.get(0) >= category.get(0).length-1) {
                going = false;
            }
        }
        UI.println("... done!");
    }

    /**
     * guess every variation of a certain word
     * @param string - initial string upon which to operate
     * @param variationsEachPosition - the string[] for the characters we want to insert
     */
    public void guessCharReplacements(List<String[]> variationsEachPosition, String string) {

        // array for how far through our search we have gotten for each char position
        ArrayList<Integer> ints = new ArrayList<>();

        // array of what we should try inserting for in each char position
        List<String[]> category = variationsEachPosition;

        int stringLength = string.length();

        // for every character count what options we have tried
        for (int i = 0; i < stringLength; i++) {
            ints.add(0);
        }

        boolean going = true;

        while (going) {

            String s = string; // string = the initial string inserted

            // for each character in the string chuck in a symbol or leave it how it is
            // NOTE: we leave how it is for all i's greater than category length
            for (int i = 0; i < stringLength; i++) {

                // if there's actually stuff in this array
                //System.out.println("Category: " + category.size() + " | " + category.toString());
                if (!category.get(i)[0].equals("-1")) {
                    String symbol = category.get(i)[ints.get(i)];
                    s = s.substring(0, i) + symbol + s.substring(i + 1);
                }
                // otherwise we ignore it
                else {

                }

            }

            //UI.println("adding : " + s);
            addPassword(s);

            // yay we did something, increment the last item of the array
            int x = category.size()-1; // item to update

            // while the item to update is full (but dont overflow the 0 item)
            while (ints.get(x) >= category.get(x).length-1 && x != 0) {
                // reset the item
                //System.out.println("Reseting " + x);
                ints.set(x, 0);
                // move to the next item
                x--;
            }
            // then at the end increment something by 1
            //System.out.println("Updating " + x + " @ " + category.get(x).length);
            ints.set(x, ints.get(x) + 1);

            //System.out.println("Item: " + x + " " + ints.get(x));

            // when the first character has run its length
            if (ints.get(0) >= category.get(x).length-1) {
                going = false;
            }
        }
        //UI.println("... done!");

    }
    //////////////////////


    //////////////////////////////////////////////

    /**
     * guess every combination of "nat" & two numbers and two letters and a character
     */
    public void addNat() {

        UI.println("Loading every combination of 'nat' and # and # and @ and @ and %");

        // NAT takes three letters from his name (N, A , T)
        // then 2 numbers
        // then 2 letters
        // then a symbol


        int stringLength = 5;

        ArrayList<String[]> possibilities = new ArrayList<>();
        possibilities.add(NUMBERS);
        possibilities.add(NUMBERS);
        possibilities.add(LETTERS);
        possibilities.add(LETTERS);
        possibilities.add(SYMBOLS);

        guessCharSeries("nat", "", possibilities, stringLength);

    }

    /**
     * guess every possible hexidecmial string of length X
     */
    public void addLiam() {

        int stringLength = UI.askInt("(Guessing Hex passwords of the format: 0xABCDEF) String length? ");

        ArrayList<String[]> category = new ArrayList<>();

        // for every character count what options we have tried
        for (int i = 0; i < stringLength; i++) {
            category.add(HEX);
        }

        guessCharSeries("0x", "", category, stringLength);
    }

    //////////////////////

    /**
     * guess every possible modification of an inputed word
     * such that the modification has two numbers and two symbols
     */
    public void addMichaela() {

        String string = UI.askString("Type a word to be modified: ");
        UI.println("Loading all '" + string + "' varients (inserting 2 symbols and 2 numbers)...");

        // chuck in a symbol
        for (String symbol : SYMBOLS) {

            for (String number : NUMBERS) {

                for (String number2 : NUMBERS) {
                    // ---------------------- //

                    // i = position to insert 1
                    for (int i = 0; i < string.length(); i++) {

                        // j = position to insert 2
                        for (int j = 0; j < string.length(); j++) {

                            for (int k = 0; k < string.length(); k++) {

                                for (int l = 0; l < string.length(); l++) {


                                    String name = string.substring(0, i) + symbol + string.substring(i + 1);

                                    name = name.substring(0, j) + symbol + name.substring(j + 1);
                                    name = name.substring(0, k) + number + name.substring(k + 1);
                                    name = name.substring(0, l) + number2 + name.substring(l + 1);


                                    addPassword(name);
                                }
                            }
                        }
                    }
                }

            }
        }
        UI.println("done");
    }
    //////////////////////

    /**
     * guess every possible modification of an inputed word
     * such that the modification has two numbers and two symbols
     *  TODO : optimize
     */
    /*public void addMichaela2() {

        String string = UI.askString("Type a word to be modified: ");
        UI.println("Loading all '" + string + "' varients (inserting 2 symbols and 2 numbers)...");

        List<String[]> variationsEachPosition = new ArrayList<>();
        variationsEachPosition.add(SYMBOLS);
        variationsEachPosition.add(SYMBOLS);
        variationsEachPosition.add(NUMBERS);
        variationsEachPosition.add(NUMBERS);

        // pad the rest with empty
        while (variationsEachPosition.size() < string.length()) {
            variationsEachPosition.add(new String[] {"-1"});
            System.out.println("padding item " + variationsEachPosition.size());
        }
        System.out.println("variant list: " + variationsEachPosition + " first: " + variationsEachPosition.get(0)[0] + " | " + variationsEachPosition.get(variationsEachPosition.size()-1)[0]);

        // create a set of all variations of the combination:
        PermutationIterator<String[]> permute = new PermutationIterator<>(variationsEachPosition);
        List<List<String[]>> allVariations = new ArrayList<>();
        while (permute.hasNext()) {
            allVariations.add(permute.next());
        }
        System.out.println("All variations: " + allVariations.size());


        for (List<String[]> aVariation : allVariations) {

            guessCharReplacements(aVariation, string);

        }


        UI.println("done");
    }*/

    public void addPassword(String s) {
        System.out.println("s : " + s);
        if (GUESS_AS_WE_GO) {

            // HASH
            // when we are using salt (!= 0)
            if (saltCode.size() != 0) {

                // iterate through and check all our salt values
                for (String salt : saltCode) {

                    byte[] saltB = salt.getBytes(StandardCharsets.UTF_8);

                    runHashing(s , saltB);

                }
            }
            // if we aren't using salt don't bother
            else {
                byte[] saltB = new byte[0]; // pass an empty byte array

                runHashing(s, saltB);
            }

        } else {
            guessedPassword.add(s);
        }
    }

    //////////////////////////

    /**
     * KEY METHOD OF THE PROGRAM!!! THIS DOES THE HASHING
     * @param password - input to hash
     * @param salt - salt to encrypt with (optional)
     * @return - output of a hashed string
     */
    public static byte[] hash(String password, byte[] salt) {

        byte[] hash = null;

        try {
            MessageDigest hasher = MessageDigest.getInstance("SHA-256");
            hasher.update(password.getBytes(StandardCharsets.UTF_8));

            if (salt.length != 0) {
                hasher.update(salt);
            }

            hash = hasher.digest();
        } catch (NoSuchAlgorithmException e) {
            e.printStackTrace();
        }

        return hash;

    }

    /**
     * Input bytes, output hex
     * @param bytes
     * @return hex
     */
    public static String bytesToHex(byte[] bytes) {
        char[] hexChars = new char[bytes.length * 2];
        for (int j = 0; j < bytes.length; j++) {
            int v = bytes[j] & 0xFF;
            hexChars[j * 2] = HEX_ARRAY[v >>> 4];
            hexChars[j * 2 + 1] = HEX_ARRAY[v & 0x0F];
        }
        return new String(hexChars);
    }

    /**
     * Main method
     * @param args - do nothing
     */
    public static void main(String[] args) {

        Cybr_Hash_Gui m = new Cybr_Hash_Gui();
        m.showGUI();

    }
}
