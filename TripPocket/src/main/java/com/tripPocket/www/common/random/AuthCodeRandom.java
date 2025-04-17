package com.tripPocket.www.common.random;

import java.util.Random;

import org.springframework.stereotype.Component;

@Component
public class AuthCodeRandom {

	public String createRandomNumber() {
		Random rand = new Random();
	    String numStr = "";
	    for(int i = 0; i < 6; i++) {
	        numStr += Integer.toString(rand.nextInt(10));
	    }
	    return numStr;
	}
}
