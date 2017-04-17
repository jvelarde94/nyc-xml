<?xml version="1.0" encoding="UTF-8" ?>
<!--
   XML Final
   Transportation in NYC
   Author: Jeremy Velarde
   Date:   11/21/2016
   File: pricing.xsl
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
		<title> Travel NYC - Pricing </title>
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
				
				<!-- apply template 1 -->
				<section>
					<xsl:apply-templates select="pricings/pricingInfo"/>
				</section>	

				<br/>

				<!-- apply template 2 -->
				<section>
					<xsl:apply-templates select="pricings/pricing">
						<xsl:sort select="spot/sName" order="ascending"/>
					</xsl:apply-templates>
				</section>
			</body>
		</html>
	</xsl:template>


	<!-- template 1 -->
	<xsl:template match="pricingInfo">
		<!-- title -->
		<div id="titlePricing">
			<h1> <xsl:value-of select="title"/> </h1>
	    </div>
				
		<!-- description -->
		<h2> <xsl:value-of select="description"/> </h2>
	</xsl:template>


	<!-- template 2 -->
	<xsl:template match="pricing">

		<!-- apply template 3 -->
		<xsl:apply-templates select="hotel/hImage">
			<xsl:sort select="img"/>
		</xsl:apply-templates>


		<table id="pricingTable">
			<tr bgcolor="#ACC5CE">
				<td colspan="2">
					<strong><big><u> Near - <xsl:value-of select="spot/sName"/> </u></big></strong>
					<br/>
					<strong> Cost: </strong>
					
					<!-- declare variable for functional programming -->
					<xsl:variable name="freeSpot" select="'Free'"/>

					<!-- functional programming -->
					<xsl:choose>
						<xsl:when test="spot/sCost > 0"> <!-- format number for spot cost -->
							<small> <xsl:value-of select="format-number(spot/sCost, '$##0.00')"/> </small>
						</xsl:when>
						<xsl:otherwise>
							<small> <xsl:value-of select="$freeSpot"/> </small>
						</xsl:otherwise>
					</xsl:choose>
				</td>
			</tr>
			<tr bgcolor="#f5ffd8">
				<th> Hotel: </th>
				<td> <xsl:value-of select="hotel/hName"/> </td>
			</tr>
			<tr bgcolor="#f5ffd8">
				<th> Cost: </th> 
				<!--format number for hotel cost -->
				<td> <xsl:value-of select="format-number(hotel/hCost,'$##0.00')"/> </td>
			</tr>
			<tr bgcolor="#f5ffd8">
				<th> Rating: </th>
				<td>
					<!--declare rating variable to use star icon -->
					<xsl:variable name="hRating" select="hotel/hRating"/>
					<!-- using template 4 -->
					<xsl:call-template name="stars">
	                  <xsl:with-param name="starIcon" select="'images/star.png'" />
	                  <xsl:with-param name="starCount" select="round($hRating)" />
	               	</xsl:call-template>
	               	<xsl:call-template name="stars">
	                  <xsl:with-param name="starIcon" select="'images/emptyStar.png'" />
	                  <xsl:with-param name="starCount" select="5 - round($hRating)" />
	               	</xsl:call-template>
	               	<br/>
	               	<!--format rating decimal to hotel rating-->
					<small> <xsl:value-of select="round($hRating)"/>-star hotel </small>
				</td>
			</tr>
			<tr bgcolor="#f5ffd8">
				<th> Nearby Restaurant: </th>
				<td> <xsl:value-of select="nearRestaurant"/> </td>
			</tr>
			
			<tr>
				<th colspan="2"> </th>
			</tr>

			<tr bgcolor="#ACC5CE">
				<th colspan="2">Methods of transportation available:</th>
			</tr>
				<tr bgcolor="#f5ffd8">
					<th> Public Transportation: </th>
					<td> <xsl:value-of select="pubTravel"/> </td>
				</tr>
				<tr bgcolor="#f5ffd8">
					<th> Private Transportation: </th>
					<td> <xsl:value-of select="priTravel"/> </td>
				</tr>

			<tr>
				<th colspan="2"> </th>
			</tr>

			<tr bgcolor="#ACC5CE">
				<th colspan="2"> Total: <br/> 
					<small><small> (Exclude food and transportation) </small></small> 
				</th>
			</tr>

		<!-- declare variable for spot cost + hotel cost-->
		<xsl:variable name="totalCost" select="spot/sCost + hotel/hCost"/>
			<tr bgcolor="#f5ffd8">
				<td colspan="2">
					<!-- functional test-->
					<xsl:choose>
						<xsl:when test="$totalCost > spot/sCost">
							<xsl:value-of select="format-number($totalCost, '$##0.00')"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="format-number(hotel/hCost, '$##0.00')"/>
						</xsl:otherwise>
					</xsl:choose>
				</td>
			</tr>
		</table>

		<br/><br/><br/><br/>
	</xsl:template>


	<!-- template 3 hotel images-->
	<xsl:template match="hImage">
		<!-- pictures of hotels -->
		<xsl:copy-of select="node()" />
	</xsl:template>


	<!-- template 4 (FUNCTIONAL PROGRAMMING) stars for hotel rating-->
	<xsl:template name="stars">
		<xsl:param name="starIcon" />
		<xsl:param name="starCount" />

		<xsl:if test="$starCount > 0">
	    	<img src="{$starIcon}"/>
			<xsl:call-template name="stars">
		      <xsl:with-param name="starIcon" select="$starIcon" />
		      <xsl:with-param name="starCount" select="$starCount - 1" />
		    </xsl:call-template>
		</xsl:if>
	</xsl:template>

</xsl:stylesheet>