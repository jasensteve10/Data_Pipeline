<!--
Cette feuille XSLT affiche pour chaque étape (Stage) la liste des activités proposées.
Pour chaque étape, elle affiche le titre puis les activités associées avec leur nom, type et durée.
-->
<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output method="html" encoding="UTF-8"/>
    <xsl:template match="/">
        <html>
            <head>
                <title>Activités par étape</title>
            </head>
            <body>
                <h2>Activités proposées par étape</h2>
                <xsl:for-each select="//Stage">
                    <h3><xsl:value-of select="title"/></h3>
                    <ul>
                        <xsl:for-each select="tokenize(activityIds, ' ')">
                            <xsl:variable name="actId" select="."/>
                            <xsl:for-each select="//Activity[@activityId=$actId]">
                                <li>
                                    <xsl:value-of select="name"/> (<xsl:value-of select="type"/>, <xsl:value-of select="durationHours"/>h)
                                </li>
                            </xsl:for-each>
                        </xsl:for-each>
                    </ul>
                </xsl:for-each>
            </body>
        </html>
    </xsl:template>
    <xsl:function name="tokenize" as="xs:string*">
        <xsl:param name="str"/>
        <xsl:param name="delim"/>
        <xsl:choose>
            <xsl:when test="contains($str, $delim)">
                <xsl:sequence select="substring-before($str, $delim)"/>
                <xsl:sequence select="tokenize(substring-after($str, $delim), $delim)"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:sequence select="$str"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:function>
</xsl:stylesheet>

