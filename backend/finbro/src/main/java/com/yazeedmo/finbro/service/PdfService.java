package com.yazeedmo.finbro.service;

import org.apache.pdfbox.pdmodel.PDDocument;
import org.apache.pdfbox.pdmodel.PDPage;
import org.apache.pdfbox.pdmodel.PDPageContentStream;
import org.apache.pdfbox.pdmodel.font.PDType1Font;
import org.apache.pdfbox.pdmodel.font.Standard14Fonts;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

@Service
public class PdfService {

    private final UserService userService;
    private final CategoryService categoryService;
    private final AccountService accountService;
    private final TransactionService transactionService;
    private final RegularPaymentService regularPaymentService;

    @Autowired
    public PdfService(
            UserService userService,
            CategoryService categoryService,
            AccountService accountService,
            TransactionService transactionService,
            RegularPaymentService regularPaymentService
    ) {
        this.userService = userService;
        this.categoryService = categoryService;
        this.accountService = accountService;
        this.transactionService = transactionService;
        this.regularPaymentService = regularPaymentService;
    }

    public byte[] createPdf() throws IOException {
        try (PDDocument document = new PDDocument()) {
            PDPage page = new PDPage();
            document.addPage(page);

            // Write content to the page
            try (PDPageContentStream contentStream = new PDPageContentStream(document, page)) {
                // Set font and add title
                contentStream.setFont(new PDType1Font(Standard14Fonts.FontName.HELVETICA_BOLD), 16);
                contentStream.beginText();
                contentStream.newLineAtOffset(50, 750);
                contentStream.showText("FinBro Stats");
                contentStream.endText();

                // Add date/time
                String dateTime = LocalDateTime.now().format(DateTimeFormatter.ofPattern("dd-MM-yyyy HH:mm:ss"));
                contentStream.beginText();
                contentStream.newLineAtOffset(400, 750);
                contentStream.showText(dateTime);
                contentStream.endText();

                // Draw horizontal line
                contentStream.setLineWidth(1.0f);
                contentStream.moveTo(50, 740);
                contentStream.lineTo(300, 740);
                contentStream.stroke();

                // Set font size for body text and add stats
                contentStream.setFont(new PDType1Font(Standard14Fonts.FontName.HELVETICA), 12);
                String[] stats = {
                        "Total Users: " + userService.getCountTotalUsers(),
                        "Total Accounts: " + accountService.getCountTotalAccounts(),
                        "Total Categories: " + categoryService.getCountTotalCategories(),
                        "Total Transactions: " + transactionService.getCountTotalTransactions(),
                        "Total Regular Payments: " + regularPaymentService.getCountTotalRegularPayments()
                };

                int yPosition = 720;
                for (String stat : stats) {
                    contentStream.beginText();
                    contentStream.newLineAtOffset(50, yPosition);
                    contentStream.showText(stat);
                    contentStream.endText();
                    yPosition -= 20;
                }
            } // The contentStream is automatically closed here

            // Write document to byte array
            ByteArrayOutputStream byteArrayOutputStream = new ByteArrayOutputStream();
            document.save(byteArrayOutputStream); // Save the document after closing the content stream
            return byteArrayOutputStream.toByteArray();
        }
    }

}
