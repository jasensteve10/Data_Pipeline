<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:main="http://www.TourCyclingOperator.com/main"
    xmlns:tp="http://www.TourCyclingOperator.com/tour_packages">

    <xsl:output method="html" indent="yes"/>

    <!-- Root template -->
    <xsl:template match="/">
        <html>
        <head>
            <title>Destinations par type</title>
            <meta charset="UTF-8"/>
        </head>
        <body>
            <h1>Destinations classées par type</h1>

            <!-- Regrouper par type -->
            <xsl:for-each select="//main:destination">
                <xsl:sort select="tp:type"/>

                <xsl:if test="position() = 1 or tp:type != preceding-sibling::main:destination[1]/tp:type">
                    <h2><xsl:value-of select="tp:type"/></h2>
                </xsl:if>

                <p>
                    <b><xsl:value-of select="tp:name"/></b>
                    (<xsl:value-of select="tp:country"/>)
                </p>
            </xsl:for-each>

        </body>
        </html>
    </xsl:template>

</xsl:stylesheet>
