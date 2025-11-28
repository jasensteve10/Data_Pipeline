<!--
Cette feuille XSLT affiche la liste des clients groupés par niveau d'expérience (BEGINNER, OCCASIONAL, REGULAR, EXPERT).
Pour chaque niveau, elle liste les clients correspondants avec leur nom et email.
-->
<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output method="html" encoding="UTF-8"/>
    <xsl:key name="exp" match="Client" use="experienceLevel"/>
    <xsl:template match="/">
        <html>
            <head>
                <title>Clients par niveau d'expérience</title>
            </head>
            <body>
                <h2>Clients par niveau d'expérience</h2>
                <xsl:for-each select="//Client[generate-id() = generate-id(key('exp', experienceLevel)[1])]">
                    <h3><xsl:value-of select="experienceLevel"/></h3>
                    <ul>
                        <xsl:for-each select="key('exp', experienceLevel)">
                            <li>
                                <xsl:value-of select="firstName"/> <xsl:value-of select="lastName"/>
                                (<xsl:value-of select="email"/>)
                            </li>
                        </xsl:for-each>
                    </ul>
                </xsl:for-each>
            </body>
        </html>
    </xsl:template>
</xsl:stylesheet>
