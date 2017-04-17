<?xml version="1.0" encoding="UTF-8" ?>
<!--
   XML Final
   Transportation in NYC
   Author: Jeremy Velarde
   Date:   11/21/2016
   File: travel.xsl
-->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs"
	version="2.0">

   <xsl:output method="html"
      doctype-system="about:legacy-compat"
      encoding="UTF-8"
      indent="yes" />

	<xsl:template match="/">
		<html>
		<title> Travel NYC - Travel </title>
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
				
				<!-- title and description of page -->
				<section>
					<xsl:apply-templates select="travels/travelInfo"/>
				</section>

				<!-- accordion of spots and info -->
			    <section>
			    	<xsl:apply-templates select="travels/travel">
			    		<xsl:sort select="attraction" order="ascending" />
			    	</xsl:apply-templates>
			    </section>

			</body>
		</html>
	</xsl:template>

	<!-- template 1 -->
	<xsl:template match="travelInfo">
		<div id="titleTravel">
			<h1> <xsl:value-of select="title"/> </h1>
		</div>
		<h2> <xsl:value-of select="pageDesc"/> </h2>
	</xsl:template>


	<!-- template 2 -->
	<xsl:template match="travel">

		<button class="accordion"> 
			<h2><center> <xsl:value-of select="attraction"/> </center></h2>
		</button>

		<div class="panel">
			<!--COPY-OF TO EXTRACT IMAGE RATHER THAN TEXT -->
			<h4> <xsl:copy-of select="image/node()" /> </h4>
			
			<b>Location:</b> <xsl:value-of select="location"/>
			
			<div id="alignDesc">
				<p> 
					<small><i> <xsl:value-of select="description"/> </i></small>
				</p>
				<p>
					<a href="pricing.xml"> Visit Now </a>
				</p>
			</div>
		</div>

		<!-- JAVASCRIPT for accordion -->
		<script type="text/javascript">
			<xsl:text>
				<![CDATA[
				var accd = document.getElementsByClassName("accordion");
				var i;

				for (i = 0; i < accd.length; i++) {
				    accd[i].onclick = function(){
				        this.classList.toggle("active");
				        this.nextElementSibling.classList.toggle("show");
				  }
				}
				]]>
			</xsl:text>
		</script>

	</xsl:template>

</xsl:stylesheet>

