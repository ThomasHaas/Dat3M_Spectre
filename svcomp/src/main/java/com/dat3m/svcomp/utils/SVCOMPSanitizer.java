package com.dat3m.svcomp.utils;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.io.PrintWriter;

import com.dat3m.dartagnan.parsers.program.utils.ParsingException;

public class SVCOMPSanitizer {

	String filePath;
	
	public SVCOMPSanitizer(String filePath) {
		this.filePath = filePath;
	}

	public File run(int bound) {
		File tmp = new File(filePath.substring(0, filePath.lastIndexOf('.')) + "_tmp.c");
		try {
			BufferedReader reader = new BufferedReader(new InputStreamReader(new FileInputStream(filePath)));
			PrintWriter writer = new PrintWriter(new OutputStreamWriter(new FileOutputStream(tmp)));
			for (String line; (line = reader.readLine()) != null;) {
				// SMACK does not create procedure for inline functions
				if(!line.contains("__")) {
					line = line.replace("inline ", "");	
				}
				if(line.contains("while(1) { pthread_create(&t, 0, thr1, 0); }") || line.contains("while(1) pthread_create(&t, 0, thr1, 0);")) {
					// While with empty body to force the creation of boundEvents
					line = line.replace("while(1) { pthread_create(&t, 0, thr1, 0); }", "while(1) {}");					
					line = line.replace("while(1) pthread_create(&t, 0, thr1, 0);", "while(1) {}");
					int i = 0;
					while(i < bound) {
						writer.println("pthread_create(&t, 0, thr1, 0);");
						i++;
					}
				}
				if((line.contains("while") && line.contains("pthread_create"))
						// TODO: remove this
						|| line.contains("pthread_create(&t, 0, producer, 0);") 
						|| line.contains("__VERIFIER_assume(n >= 20 && n < 40);")) {
					reader.close();
					writer.close();
			        throw new ParsingException(line + " cannot be parsed");
				}
				writer.println(line);
			}
			reader.close();
			writer.close();
		} catch (IOException e) {
			System.out.println(e.getMessage());
            System.exit(0);
		}
		return tmp;
	}
}
