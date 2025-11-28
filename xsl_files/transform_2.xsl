<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    
    <xsl:template match="/">
        <html>
            <head><title>Clients from France</title></head>
            <body>
                <h2>Clients living in France</h2>
                
                <!-- Apply templates only to French clients -->
                <xsl:apply-templates 
                    select="CyclingTourDatabase/Clients/Client[countryOfResidence='France']"/>
            </body>
        </html>
    </xsl:template>
    
    <!-- Template for each client -->
    <xsl:template match="Client">
        <p>
            <b><xsl:value-of select="firstName"/> <xsl:value-of select="lastName"/></b><br/>
            Country:
            <span style="color:blue">
                <xsl:value-of select="countryOfResidence"/>
            </span>
        </p>
    </xsl:template>
    
</xsl:stylesheet>
