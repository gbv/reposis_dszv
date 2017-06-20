<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:i18n="xalan://org.mycore.services.i18n.MCRTranslation"
  xmlns:mcrver="xalan://org.mycore.common.MCRCoreVersion"
  exclude-result-prefixes="i18n mcrver">

  <xsl:import href="resource:xsl/layout/mir-common-layout.xsl" />

  <xsl:template  name="mir.header">
    <div id="head" class="container">
      <div class="row">
        <div id="header_back">
          <!-- site logo -->
          <div id="site_logo" role="projectlogo" class="col-sm-3">
            <h1><a href="http://dszv.it/{$CurrentLang}/"><img alt="DSZV-Logo" src="{$WebApplicationBaseURL}images/logos/dszv.gif" /></a></h1>
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
      <form action="{$WebApplicationBaseURL}servlets/solr/find?q={0}" class="navbar-form form-inline" role="search">
        <div class="form-group">
          <input name="q" placeholder="{i18n:translate('mir.cosmol.navsearch.placeholder')}" title="{i18n:translate('mir.cosmol.navsearch.title')}" class="form-control search-query" id="searchInput" type="text" />
        </div>
        <button type="submit" title="{i18n:translate('mir.cosmol.navsearch.title')}" class="btn btn-primary"><span class="glyphicon glyphicon-search"></span></button>
      </form>
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
        </ul>
      </nav>
    </div>
  </xsl:template>

  <xsl:template name="mir.footer">
    <div class="container">
        <div id="menu" class="row">
            <div class="col-xs-6">
                <ul id="sub_menu">
                  <xsl:for-each select="$loaded_navigation_xml/menu[@id='below']/item">
                    <xsl:apply-templates select="." />
                  </xsl:for-each>
                </ul>
            </div>
            <div class="col-xs-6">
                <div id="copyright">© <xsl:value-of select="$MCR.NameOfProject" /> 2017</div>
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