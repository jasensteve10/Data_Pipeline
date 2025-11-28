<!--
Cette feuille XSLT affiche les destinations groupées par type (ville, montagne, etc.).
Pour chaque type, elle liste les destinations correspondantes avec leur nom et région.
-->
<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output method="html" encoding="UTF-8"/>
    <xsl:key name="type" match="Destination" use="type"/>
    <xsl:template match="/">
        <html>
            <head>
                <title>Destinations par type</title>
            </head>
            <body>
                <h2>Destinations par type</h2>
                <xsl:for-each select="//Destination[generate-id() = generate-id(key('type', type)[1])]">
                    <h3><xsl:value-of select="type"/></h3>
                    <ul>
                        <xsl:for-each select="key('type', type)">
                            <li>
                                <xsl:value-of select="name"/> (<xsl:value-of select="region"/>)
                            </li>
                        </xsl:for-each>
                    </ul>
                </xsl:for-each>
            </body>
        </html>
    </xsl:template>
</xsl:stylesheet>
