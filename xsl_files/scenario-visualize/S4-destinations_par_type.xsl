
<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:main="http://www.TourCyclingOperator.com/main"
    xmlns:tp="http://www.TourCyclingOperator.com/tour_packages">
    <xsl:output method="html" encoding="UTF-8"/>
    <xsl:key name="type" match="main:destination" use="tp:type"/>
    <xsl:template match="/">
        <html>
            <head>
                <title>Destinations par type</title>
            </head>
            <body>
                <h2>Destinations par type</h2>
                <xsl:for-each select="//main:destination[generate-id() = generate-id(key('type', tp:type)[1])]">
                    <h3><xsl:value-of select="tp:type"/></h3>
                    <ul>
                        <xsl:for-each select="key('type', tp:type)">
                            <li>
                                <xsl:value-of select="tp:name"/> (<xsl:value-of select="tp:region"/>)
                            </li>
                        </xsl:for-each>
                    </ul>
                </xsl:for-each>
            </body>
        </html>
    </xsl:template>
</xsl:stylesheet>
