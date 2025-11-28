<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet
    version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:main="http://www.TourCyclingOperator.com/main"
    xmlns:tp="http://www.TourCyclingOperator.com/tour_packages">

    <xsl:output method="html" encoding="UTF-8" />

    <!-- Point d'entrée -->
    <xsl:template match="/">
        <html>
            <head>
                <title>Activités par étape</title>
            </head>
            <body>
                <h2>Activités proposées par étape</h2>

                <!-- Pour chaque Stage -->
                <xsl:for-each select="/main:cyclingTourDatabase/main:stage">
                    <!-- On récupère l'ID du TourPackage lié à cette étape -->
                    <xsl:variable name="tourId" select="@tourId" />
                    <xsl:variable name="tour"
                                  select="/main:cyclingTourDatabase/main:tourPackage[@tourId = $tourId]" />

                    <!-- Affichage du TourPackage -->
                    <h3>
                        Tour package:
                        <xsl:value-of select="$tour/tp:title" />
                    </h3>

                    <!-- Affichage du titre de l'étape -->
                    <p>
                        <strong>Stage:</strong>
                        <xsl:value-of select="tp:title" />
                    </p>

                    <!-- Liste des activités -->
                    <ul>
                        <!-- On récupère la chaîne d'IDs d'activités (ex: 'act_1 act_2') -->
                        <xsl:variable name="ids" select="normalize-space(tp:activityIds)" />
                        <!-- On appelle un template récursif pour traiter chaque ID -->
                        <xsl:call-template name="liste-activites">
                            <xsl:with-param name="ids" select="$ids" />
                        </xsl:call-template>
                    </ul>

                    <hr/>
                </xsl:for-each>

            </body>
        </html>
    </xsl:template>

    <!-- Template récursif qui découpe la liste d'IDs et affiche chaque activité -->
    <xsl:template name="liste-activites">
        <xsl:param name="ids" />

        <xsl:if test="$ids != ''">
            <!-- On prend le premier ID (avant l'espace éventuel) -->
            <xsl:variable name="firstId">
                <xsl:choose>
                    <xsl:when test="contains($ids, ' ')">
                        <xsl:value-of select="substring-before($ids, ' ')" />
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="$ids" />
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:variable>

            <!-- On recherche l'activité correspondante -->
            <xsl:for-each select="/main:cyclingTourDatabase/main:activity[@activityId = $firstId]">
                <li>
                    <xsl:value-of select="tp:name" />
                    (<xsl:value-of select="tp:type" />,
                     <xsl:value-of select="tp:durationHours" />h)
                </li>
            </xsl:for-each>

            <!-- S'il reste d'autres IDs, on rappelle le template récursivement -->
            <xsl:if test="contains($ids, ' ')">
                <xsl:call-template name="liste-activites">
                    <xsl:with-param name="ids" select="substring-after($ids, ' ')" />
                </xsl:call-template>
            </xsl:if>
        </xsl:if>
    </xsl:template>

</xsl:stylesheet>
