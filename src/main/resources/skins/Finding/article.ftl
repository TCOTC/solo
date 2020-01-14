<#--

    Solo - A small and beautiful blogging system written in Java.
    Copyright (c) 2010-present, b3log.org

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU Affero General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU Affero General Public License for more details.

    You should have received a copy of the GNU Affero General Public License
    along with this program.  If not, see <https://www.gnu.org/licenses/>.

-->
<#include "../../common-template/macro-common_head.ftl">
<#include "macro-comments.ftl">
<#include "../../common-template/macro-comment_script.ftl">
<!DOCTYPE html>
<html>
    <head>
        <@head title="${article.articleTitle} - ${blogTitle}" description="${article.articleAbstract?html}">
            <link rel="stylesheet"
                  href="${staticServePath}/skins/${skinDirName}/css/base.css?${staticResourceVersion}"/>
        <#if previousArticlePermalink??>
            <link rel="prev" title="${previousArticleTitle}" href="${servePath}${previousArticlePermalink}">
        </#if>
        <#if nextArticlePermalink??>
            <link rel="next" title="${nextArticleTitle}" href="${servePath}${nextArticlePermalink}">
        </#if>
        </@head>
    </head>
    <body class="nav-closed">
        <div class="nav">
            <#include "side.ftl">
        </div>
        <div class="site-wrapper">
            <#include "header.ftl">
            <main>
                <article class="post fn-wrap">
                    <header>
                        <h2 class="post-title">
                            <a rel="bookmark" href="${servePath}${article.articlePermalink}">
                                ${article.articleTitle}
                            </a>
                            <#if article.articlePutTop>
                            <sup class="post-tip">
                                ${topArticleLabel}
                            </sup>
                            </#if>
                        </h2>
                        <section class="post-meta">
                            <#list article.articleTags?split(",") as articleTag>
                            <span>
                                <a rel="tag" href="${servePath}/tags/${articleTag?url('UTF-8')}">
                                    ${articleTag}</a><#if articleTag_has_next>,</#if>
                            </span>
                            </#list>
                            <time>${article.articleUpdateDate?string("yyyy-MM-dd")}</time>
                        </section>
                    </header>
                    <section class="post-content post-content--article vditor-reset">
                        ${article.articleContent}
                        <#if "" != article.articleSign.signHTML?trim>
                        <div class="marginTop12">
                            ${article.articleSign.signHTML}
                        </div>
                        </#if>
                    </section>
                    <footer>
                        <figure class="post-author">
                            <a href="${servePath}/authors/${article.authorId}"
                               title="${article.authorName}" alt="${article.authorName}"
                               style="background-image: url('${article.authorThumbnailURL}')">
                                <span class="fn-none">${article.authorName}</span>
                            </a>
                        </figure>
                        <div class="share fn-right">
                            <span class="icon icon-wechat"
                                  data-type="wechat"
                                  data-title="${article.articleTitle}"
                                  data-blogtitle="${blogTitle}"
                                  data-url="${servePath}${article.articlePermalink}"
                                  data-avatar="${article.authorThumbnailURL}"></span>
                            <span class="icon icon-weibo" data-type="weibo"></span>
                            <span class="icon icon-twitter" data-type="twitter"></span>
                            <span class="icon icon-qqz" data-type="qqz"></span>
                        </div>
                    </footer>
                </article>
                <#if 0 != relevantArticlesDisplayCount>
                <div id="relevantArticles" class="fn-wrap"></div>
                </#if>
                <#if 0 != randomArticlesDisplayCount>
                <div id="randomArticles" class="fn-wrap"></div>
                </#if>
                <#if externalRelevantArticlesDisplayCount?? && 0 != externalRelevantArticlesDisplayCount>
                <div id="externalRelevantArticles" class="fn-wrap"></div>
                </#if>
                <#if commentable>
                <div id="vcomment" class="fn-wrap" data-name="${article.authorName}" data-postId="${article.oId}"></div>
                <div id="soloComments" style="display: none;">
                    <@comments commentList=articleComments article=article></@comments>
                </div>
                </#if>
            </main>
            <#if nextArticlePermalink?? || previousArticlePermalink??>
            <aside class="read-next">
                <#if nextArticlePermalink??>
                <div class="read-next-story " style="background-image: url('${staticServePath}/skins/${skinDirName}/images/next.jpg')"
                     onclick="window.location = '${servePath}${nextArticlePermalink}'">
                    <section class="post">
                        <h2>${nextArticleTitle}</h2>
                        <p>${nextArticleAbstract}</p>
                    </section>
                </div>
                </#if>
                <#if previousArticlePermalink??>
                <div class="read-next-story prev " style="background-image: url('${staticServePath}/skins/${skinDirName}/images/preview.jpg')"
                     onclick="window.location = '${servePath}${previousArticlePermalink}'">
                    <section class="post">
                        <h2>${previousArticleTitle}</h2>
                        <p>${previousArticleAbstract}</p>
                    </section>
                </div>
                </#if>
            </aside>
            </#if>
            <#include "footer.ftl">

            <@comment_script oId=article.oId commentable=article.commentable>
            page.tips.externalRelevantArticlesDisplayCount = "${externalRelevantArticlesDisplayCount}";
            <#if 0 != externalRelevantArticlesDisplayCount>
            page.loadExternalRelevantArticles("<#list article.articleTags?split(",") as articleTag>${articleTag}<#if articleTag_has_next>,</#if></#list>");
            </#if>
            <#if 0 != randomArticlesDisplayCount>
            page.loadRandomArticles();
            </#if>
            <#if 0 != relevantArticlesDisplayCount>
            page.loadRelevantArticles('${article.oId}', '<h4>${relevantArticles1Label}</h4>');
            </#if>
             </@comment_script>
        </div>
    </body>
</html>
