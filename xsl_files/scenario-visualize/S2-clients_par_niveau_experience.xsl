<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet
    version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:main="http://www.TourCyclingOperator.com/main"
    xmlns:cg="http://www.TourCyclingOperator.com/clients_and_guides">

    <xsl:output method="html" encoding="UTF-8"/>

    <!--
        Clé de groupement : on groupe les cg:client
        par valeur de cg:experienceLevel
    -->
    <xsl:key
        name="exp"
        match="cg:client"
        use="normalize-space(cg:experienceLevel)"/>

    <xsl:template match="/">
        <html>
            <head>
                <title>Clients par niveau d'expérience</title>
            </head>
            <body>
                <h2>Clients par niveau d'expérience</h2>

                <!--
                    Pour chaque niveau distinct :
                    on prend le premier client de chaque groupe.
                -->
                <xsl:for-each
                    select="//cg:client
                            [generate-id()
                             = generate-id(
                                   key('exp',
                                       normalize-space(cg:experienceLevel)
                                   )[1]
                               )]">

                    <!-- Titre du groupe = niveau d'expérience -->
                    <h3>
                        <xsl:value-of select="cg:experienceLevel"/>
                    </h3>

                    <ul>
                        <!-- Tous les clients avec ce niveau -->
                        <xsl:for-each
                            select="key('exp',
                                        normalize-space(cg:experienceLevel))">
                            <li>
                                <xsl:value-of select="cg:firstName"/>
                                <xsl:text> </xsl:text>
                                <xsl:value-of select="cg:lastName"/>
                                <xsl:text> (</xsl:text>
                                <xsl:value-of select="cg:email"/>
                                <xsl:text>)</xsl:text>
                            </li>
                        </xsl:for-each>
                    </ul>

                </xsl:for-each>
            </body>
        </html>
    </xsl:template>

</xsl:stylesheet>
