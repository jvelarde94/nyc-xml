<?xml version="1.0" encoding="UTF-8" ?>
<!--
   XML Final
   Transportation in NYC
   Author: Jeremy Velarde
   Date:   11/21/2016
   File: index.xsl
-->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:xs="http://www.w3.org/2001/XMLSchema"
	version="2.0">

   <xsl:output method="html"
      doctype-system="about:legacy-compat"
      encoding="UTF-8"
      indent="yes" />

	<xsl:template match="/">
		<html>
		<title> Travel NYC - Home </title>
			<head>
				<link href="style.css" rel="stylesheet" type="text/css" />
			</head>
		    <body>
		    	<header>
		    	<!-- navigation bar -->
				    <div class="navbar">
				    	<ul>
					   		<li><a href="index.xml"> Home </a> </li> 
					   		<li><a href="travel.xml"> Travel </a> </li> 
					   		<li><a href="pricing.xml"> Pricing </a> </li>
				    	</ul>
				    </div>
				</header>
				
				<!-- Extracts and outputs title and description from index.xml in h1 -->
				<section>
					<xsl:apply-templates select="index/home"/>
				</section>

				<!-- Images from template-->
				<section>
					<xsl:apply-templates select="index/home/images">
						<xsl:sort select="img" />
					</xsl:apply-templates>
				</section>
			</body>
		</html>
	</xsl:template>


	<!-- template 1 - title/description-->
	<xsl:template match="home">
		<div id="titleHome">
			<h1> <xsl:value-of select="title"/> </h1>
		</div>
		<h2> <xsl:value-of select="description"/> </h2>
	</xsl:template>


	<!-- template 2 - images -->
	<xsl:template match="images">

		<!-- scrollbox with images - clicking image brings you to travel page-->
		<div id="container">
			<a href="travel.xml">
				<xsl:copy-of select="node()" />
			</a>
		</div>
	</xsl:template>

</xsl:stylesheet>