package com.yazeedmo.finbro;

import io.swagger.v3.oas.annotations.OpenAPIDefinition;
import io.swagger.v3.oas.annotations.info.Info;
import org.apache.pdfbox.pdmodel.PDDocument;
import org.apache.pdfbox.pdmodel.PDPage;
import org.apache.pdfbox.pdmodel.PDPageContentStream;
import org.apache.pdfbox.pdmodel.common.PDRectangle;
import org.apache.pdfbox.pdmodel.font.*;
import org.apache.pdfbox.pdmodel.graphics.image.PDImageXObject;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.scheduling.annotation.EnableScheduling;

@SpringBootApplication
@OpenAPIDefinition(info = @Info(title = "FinBro API", version = "v1"))
@EnableScheduling
public class FinbroApplication {

	public static void main(String[] args) {

		// testPDF();

		SpringApplication.run(FinbroApplication.class, args);
	}

	private static void testPDF() {

		try (PDDocument document = new PDDocument()) {

			// Add a blank page
			PDPage page = new PDPage();
			document.addPage(page);

			PDRectangle mediaBox = page.getMediaBox();
			float pageWidth = mediaBox.getWidth();
			float pageHeight = mediaBox.getHeight();

			// Start writing content to the page
			try (PDPageContentStream contentStream = new PDPageContentStream(document, page)) {

				// Set font and font size
				contentStream.setFont(new PDType1Font(Standard14Fonts.FontName.HELVETICA_BOLD), 16);

				contentStream.setLineWidth(2.0f);
				contentStream.setStrokingColor(0, 0, 0);

				float margin = 50;
				float x = margin;
				float y = margin;
				float width = pageWidth - 2 * margin;
				float height = pageHeight - 2 * margin;

				contentStream.addRect(x, y, width, height);
				contentStream.stroke();


			}

			// Save the document
			document.save("example.pdf");
			System.out.println("PDF created successfully");

		}
		catch (Exception e) {
			e.printStackTrace();
		}

	}

}
