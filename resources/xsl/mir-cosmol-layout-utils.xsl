<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:i18n="xalan://org.mycore.services.i18n.MCRTranslation"
  xmlns:mcrver="xalan://org.mycore.common.MCRCoreVersion"
  xmlns:mcrxsl="xalan://org.mycore.common.xml.MCRXMLFunctions"
  xmlns:calendar="xalan://java.util.GregorianCalendar"
  exclude-result-prefixes="i18n mcrver mcrxsl calendar">

  <xsl:import href="resource:xsl/layout/mir-common-layout.xsl" />

  <xsl:template  name="mir.header">
    <div id="head" class="container">
      <div class="row">
        <div id="header_back">
          <!-- site logo -->
          <div id="site_logo" role="projectlogo" class="col-sm-3">
            <h1><a href="http://dszv.it/{$CurrentLang}/"><img alt="DSZV-Logo" src="{$WebApplicationBaseURL}images/logos/logo-dszv-jubi-336.jpg" /></a></h1>
          </div>
          <div id="project_info" class="col-sm-9">
            <h2 id="project_title">
            <xsl:choose>
              <xsl:when test="$CurrentLang='it'"><img alt="istituzione" src="{$WebApplicationBaseURL}images/logos/titolo.gif" /></xsl:when>
              <xsl:otherwise><img alt="Institution" src="{$WebApplicationBaseURL}images/logos/title.gif" /></xsl:otherwise>
            </xsl:choose>
            </h2>
            <h3 id="project_slogan">
              <a href="{$WebApplicationBaseURL}">
                <xsl:value-of select="i18n:translate('dszv.slogan')" />
              </a>
            </h3>
          </div>
          <div class="navbar navbar-default mir-prop-nav pull-right">
            <nav class="mir-prop-nav-entries">
              <ul class="nav navbar-nav">
                <xsl:call-template name="mir.loginMenu" />
              </ul>
            </nav>
          </div>
        </div>
        <noscript>
          <div class="mir-no-script alert alert-warning text-center" style="border-radius: 0;">
            <xsl:value-of select="i18n:translate('mir.noScript.text')" />&#160;
            <a href="http://www.enable-javascript.com/de/" target="_blank">
              <xsl:value-of select="i18n:translate('mir.noScript.link')" />
            </a>
            .
          </div>
        </noscript>
      </div>
    </div>
  </xsl:template>

  <xsl:template name="mir.top-navigation">
    <div id="searchLangSwitch" class="pull-right">
      <div id="langswitch">
        <xsl:choose>
          <xsl:when test="$CurrentLang='it'"><a href="?lang=de"><xsl:value-of select="i18n:translate('dszv.language')"/></a></xsl:when>
          <xsl:otherwise><a href="?lang=it"><xsl:value-of select="i18n:translate('dszv.language')"/></a></xsl:otherwise>
        </xsl:choose>
      </div>
      <div class="searchfield_box">
        <form action="{$WebApplicationBaseURL}servlets/solr/find" class="navbar-form form-inline" role="search">
          <div class="form-group">
            <input name="condQuery" placeholder="{i18n:translate('mir.navsearch.placeholder')}" title="{i18n:translate('mir.cosmol.navsearch.title')}" class="form-control search-query" id="searchInput" type="text" />
            <xsl:choose>
                <xsl:when test="mcrxsl:isCurrentUserInRole('admin') or mcrxsl:isCurrentUserInRole('editor')">
                  <input name="owner" type="hidden" value="createdby:*" />
                </xsl:when>
                <xsl:when test="not(mcrxsl:isCurrentUserGuestUser())">
                  <input name="owner" type="hidden" value="createdby:{$CurrentUser}" />
                </xsl:when>
              </xsl:choose>
          </div>
          <button type="submit" title="{i18n:translate('mir.cosmol.navsearch.title')}" class="btn btn-primary"><span class="fa fa-search"></span></button>
        </form>
      </div>
    </div>
  </xsl:template>

  <xsl:template name="mir.navigation">
    <div class="navbar navbar-default mir-side-nav">
      <nav class="mir-main-nav-entries">
        <ul class="nav navbar-nav">
          <xsl:apply-templates select="$loaded_navigation_xml/menu[@id='main']" />
          <xsl:apply-templates select="$loaded_navigation_xml/menu[@id='search']" />
          <xsl:apply-templates select="$loaded_navigation_xml/menu[@id='browse']" />
          <xsl:apply-templates select="$loaded_navigation_xml/menu[@id='publish']" />
          <xsl:call-template name="mir.basketMenu" />
          <xsl:apply-templates select="$loaded_navigation_xml/menu[@id='misc']" />

          <li class="dropdown">
            <a href="#" data-toggle="dropdown" class="dropdown-toggle" id="dszvLibrary"><xsl:value-of select="i18n:translate('dszv.library')" /><span class="caret"></span></a>
            <ul aria-labelledby="dszvLibrary" role="menu" class="dropdown-menu">
              <li>
                <a href="http://vzlbs2.gbv.de/DB=46/"><xsl:value-of select="i18n:translate('dszv.onlinecatalog')" /></a>
              </li>
            </ul>
          </li>

          <li class="dropdown">
            <a href="#" data-toggle="dropdown" class="dropdown-toggle" id="dszvInstitute"><xsl:value-of select="i18n:translate('dszv.institute')" /><span class="caret"></span></a>
            <ul aria-labelledby="dszvInstitute" role="menu" class="dropdown-menu">
              <li>
                <xsl:choose>
                  <xsl:when test="$CurrentLang='it'"><a href="http://www.dszv.it/it/contatti/"><xsl:value-of select="i18n:translate('dszv.contact')" /></a></xsl:when>
                  <xsl:otherwise><a href="http://www.dszv.it/de/kontakt/"><xsl:value-of select="i18n:translate('dszv.contact')" /></a></xsl:otherwise>
                </xsl:choose>
              </li>
              <li>
                <xsl:choose>
                  <xsl:when test="$CurrentLang='it'"><a href="http://www.dszv.it/it/crediti/"><xsl:value-of select="i18n:translate('dszv.imprint')" /></a></xsl:when>
                  <xsl:otherwise><a href="http://www.dszv.it/de/impressum/"><xsl:value-of select="i18n:translate('dszv.imprint')" /></a></xsl:otherwise>
                </xsl:choose>
              </li>
              <li>
                <xsl:choose>
                  <xsl:when test="$CurrentLang='it'"><a href="https://www.iubenda.com/privacy-policy/7992015/legal"><xsl:value-of select="i18n:translate('dszv.privacy')" /></a></xsl:when>
                  <xsl:otherwise><a href="https://www.iubenda.com/privacy-policy/33631120/legal"><xsl:value-of select="i18n:translate('dszv.privacy')" /></a></xsl:otherwise>
                </xsl:choose>
                
              </li>
            </ul>
          </li>
        </ul>
      </nav>
    </div>
  </xsl:template>

  <xsl:template name="mir.footer">
    <div class="container">
        <div id="menu" class="row">
            <div class="col-xs-6 small">
                Deutsches Studienzentrum in Venedig | Palazzo Barbarigo della Terrazza | S.Polo 2765/a Calle Corner 30125 Venezia
                Tel. 0039 041 5206355 | Fax. 0039 041 5206780 | <a href="http://www.dszv.it" title="Home">www.dszv.it</a>
            </div>
            <div class="col-xs-6 small">
                <xsl:variable name="tmp" select="calendar:new()"/>
                <div id="copyright">
                    <xsl:text>© </xsl:text>
                    <xsl:value-of select="$MCR.NameOfProject" />
                    <xsl:text> </xsl:text>
                    <xsl:value-of select="calendar:get($tmp, 1)"/>
                </div>
            </div>
        </div>
        <div id="credits" class="row">
            <div class="col-xs-12">
                <div id="powered_by">
                    <a href="http://www.mycore.de">
                        <xsl:variable name="mcr_version" select="concat('MyCoRe ',mcrver:getCompleteVersion())" />
                        <img src="{$WebApplicationBaseURL}mir-layout/images/mycore_logo_powered_120x30_blaue_schrift_frei.png" title="{$mcr_version}" alt="powered by MyCoRe"/>
                    </a>
                </div>
            </div>
        </div>
    </div>
  </xsl:template>

</xsl:stylesheet>
