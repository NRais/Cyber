/*
CHALLENGE: NT Master

- "nc challs.m0lecon.it 10000"
- give me two positive integers a,b such that a>b and gcd(a,b)+lcm(a,b)=N?
- being not possible to solve that fast I instead tried any input (ex -2) [nothing]
- tried injecting command code "sleep 10s", [nothing] input is clearly not being executed

- shifted to writing a java program that connects to the server parses 
- reads lines from the server to find N and calculates the answer
- this works successfully and gets past the first few attempts (but algorithms are complicated at this size)
- when you get one correct each subsequent number gets proportionally larger
- when the numbers got too large to parse I realized it wasn't an actual math challenge
- the answer is solved by postulating a = N-1 , b = 1 
- this way it is not necessary to use Integers (which are too small to store the numbers anyway)

*/

public void launch() {
	
	try {
		
		// close socket
		if (socket != null) {
			socket.close();
			socket = null;
		}

		// create a socket connection
		socket = new Socket(server, IRC_PORT);

		// create scanner to read from socket
		serverIn = new Scanner(socket.getInputStream());
		// create printer to write to socket
		serverOut = new PrintStream(socket.getOutputStream());

		Thread thread = new Thread() {
			@Override
			public void run()
			{
				//read data from client
				while(serverIn.hasNextLine()) {
					String data = serverIn.nextLine();
					// print the last part of the line
					System.out.println(" | " + data);
					UI.println(data);

					if (data.contains("N =")) {
						String shortData = data.substring(4);

						// x is the number of characters of the end that are 0
						int x = 1;

						// as long as we are looking at a 0 increment x
						while (shortData.toCharArray()[shortData.length() - x] == ('0')) {
							x++;
						}

						String firing = shortData.substring(0, shortData.length() - x);

						System.out.println("FOUND " + shortData + " FIRING " + firing);

						Long N = Long.parseLong(shortData.substring(shortData.length() - x));


						fire(firing, N);
					}
				}
			}
		};

		thread.start();




	} catch (IOException e) {
		System.out.println("Failed connection " + e);
	}
}

private void fire(String firing, Long N) {
	// so we want to calculate two integers such that gcd + lcm = N

	System.out.println("FIRING ");

	Long finalA = -1l;
	Long finalB = -1l;
	

	Long start = N -1; // we know we dont need to start at N

	//OLD CODE to actually find the Greatest Common Denominator
	// for each value of gcd and lcm
	// gcd starts at 0 and goes to N and lcm is the rest (such that they add to N)

	// loop through values until for a & b until we get matching
	// NOTE: we know a > b
	
	// but also for N's with lots of 0's on the end we won't bother haha
	/*if (N % 100 == 0) {
		System.out.println("Starting early");
		start = N / 2;
	}


	//OLD CODE to actually find the Greatest Common Denominator
	outerloop:
	for (Long b = 2l; b < N/2; b++) {
		for (Long a = start; a > b; a--) {


			// only bother to calculate gcd if a is really close to N or a is close to b
			//if (a > N - a | a < 2*b | a > b/2 ) {

				// do this so we only have to calculate it once
				Long gcdOfThem = gcdThing(a, b);

				if (gcdOfThem + lcm(a, b, gcdOfThem) == N) {
					// then we found the right one
					finalA = a;
					finalB = b;
					break outerloop;
				}
			//}
		}
	}*/

	System.out.println("SENDING: " + firing + "" + (N-1) + " " + 1);
	serverOut.println(firing + "" + (N-1) + " " + 1);

}

//OLD CODE to actually find the Greatest Common Denominator and Least Common Factor
/*
private static Long gcdThing(Long a, Long b) {
	BigInteger b1 = BigInteger.valueOf(a);
	BigInteger b2 = BigInteger.valueOf(b);
	BigInteger gcd = b1.gcd(b2);
	return gcd.longValue();
}
private static long lcm(Long a, Long b, Long gcd)
{
	return a * (b / gcd);
}*/