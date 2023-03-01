<%@ page import="eu.telecom_bretagne.cabinet_recrutement.data.model.Entreprise" %>
<%@ page import="eu.telecom_bretagne.cabinet_recrutement.service.IServiceEntreprise" %>
<%@ page import="eu.telecom_bretagne.cabinet_recrutement.front.utils.ServicesLocator" %>
<%@ page import="eu.telecom_bretagne.cabinet_recrutement.front.utils.Utils" %>
<%@ page import="eu.telecom_bretagne.cabinet_recrutement.data.model.Candidat" %>
<%@ page import="eu.telecom_bretagne.cabinet_recrutement.service.IServiceCandidat" %>

<%--
  Created by IntelliJ IDEA.
  User: mathieu
  Date: 27/02/2023
  Time: 16:52
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html" pageEncoding="ISO-8859-1" %>
<%@ page errorPage="/erreur.jsp" %>
<%
    String action = request.getParameter("action");
    if (action == null || action.equals(""))
        action = "accueil.jsp";
    else
        action = action + ".jsp";
%>

<!DOCTYPE html>
<html lang="en">
<jsp:include page="fragments/head.html"/>
<body>
<div id="wrapper">
    <!-- Navigation -->
    <nav class="navbar
                  navbar-default
                  navbar-static-top"
         role="navigation"
         style="margin-bottom: 0">
        <jsp:include page="fragments/bandeau.jsp"/>
        <jsp:include page="fragments/menu.jsp"/>
    </nav>
    <div id="page-wrapper">
        <h4>Mise à jour des informations d'une candidature</h4>
        <% Candidat candidat = (Candidat) session.getAttribute("candidat");

          IServiceQualification serviceQualification = (IServiceQualificiation) ServicesLocator.getInstance().getRemoteInterface("ServiceQualification");
          IServiceSecteur serviceSecteur = (IServiceSecteur) ServicesLocator.getInstance().getRemoteInterface("ServiceSecteur");
          <!-- Object candidat = session.getAttribute("candidat"); -->

        %>
        <% if (request.getParameter("submit") != null) {
        %>
        <h4>Tentative de MAJ de la candidature</h4>
        <%
            try {
                //Entreprise candidat = (Entreprise) session.getAttribute("utilisateur");

                candidat.setAdresseEmail(request.getParameter("adresse_mail"));
                candidat.setNom(request.getParameter("nom"));
                candidat.setPrenom(request.getParameter("prenom"));
                candidat.setAdressePostale(request.getParameter("adresse_postale"));
                candidat.setCv(request.getParameter("CV"));
                IServiceCandidat serviceCandidat = (IServiceCandidat) ServicesLocator.getInstance().getRemoteInterface("ServiceCandidat");
                serviceCandidat.execUpdate(candidat);
                response.sendRedirect("mon_profil_candidat.jsp");
        %>
        <h4>MAJ OK de candidature</h4>
        <%
        } catch (Exception e) {

        %>

        <h4>Erreur lors de la mise a jour de la candidature</h4>
        <%=e.getMessage()%>

        <%
            }
        } else {
            //Entreprise candidat = (Entreprise) session.getAttribute("utilisateur");
        %>
        <div class="col-lg-offset-2 col-lg-8
                        col-xs-12">
            <form role="form" action="maj_candidature.jsp" method="get">
            <!-- --------------start modif---------------------------------------------------------- -->
                <input type="hidden" name="ID" value=" <%=candidat.getIdCandidat()%>"/>
                <div class="form-group">
                    <label>ID : <%=candidat.getIdCandidat()%>
                    </label>
                </div>
                <div class="form-group">
                    <label>Nom : </label>
                    <input class="form-control" placeholder="Nom de l'entreprise" name="nom"
                           value="<%=candidat.getNom()%> "/>
                </div>
                <div class="form-group">
                    <label>Prenom : </label>
                    <input class="form-control" placeholder="Nom de l'entreprise" name="prenom"
                           value="<%=candidat.getPrenom()%> "/>
                </div>
                <div class="form-group">
                    <label>Adresse postale</label>
                    <input class="form-control" placeholder="Adresse postale (ville)" name="adresse_postale"
                           value="<%=candidat.getAdressePostale()%>"/>
                </div>
                <div class="form-group">
                    <label>Adresse mail</label>
                    <input class="form-control" placeholder="Adresse postale (ville)" name="adresse_mail"
                           value="<%=candidat.getAdresseEmail()%>"/>
                </div>
                <div class="form-group">
                    <label>CV : </label>
                    <textarea class="form-control" placeholder="Descriptif de l'entreprise" rows="5"
                              name="CV"><%=Utils.text2HTML(candidat.getCv())%> </textarea>
                </div>

                <div class="col-lg-3">
                    <div class="form-group">
                        <label>Niveau de qualification</label>
                           <small>
                              <% for(NiveauQualification nq : niveauqualif){
                                 if(candidat.getNiveauQualification() == nq){ %>
                                    <div class="radio">
                                       <label>
                                          <input type="radio" name="niveau" value=<%=nq.getIdQualification() %> checked /><%=nq.getIntituleQualification() %>
                                       </label>
                                    </div>
                                 <% }
                                 else{ %>
                                    <div class="radio">
                                       <label>
                                          <input type="radio" name="niveau" value=<%=nq.getIdQualification() %> /><%=nq.getIntituleQualification() %>
                                       </label>
                                    </div>
                                 <% } %>
                              <%} %>
                           </small>
                    </div>
                </div>

                <div class="col-lg-3">
                    <div class="form-group">
                        <label>Secteur(s) d'activité</label>
                           <small>
                              <% for(SecteurActivite s : niveauqualif){
                                 if(candidat.getNiveauQualification() == nq){ %>
                                    <div class="radio">
                                       <label>
                                          <input type="radio" name="niveau" value=<%=nq.getIdQualification() %> checked /><%=nq.getIntituleQualification() %>
                                       </label>
                                    </div>
                                 <% }
                                 else{ %>
                                    <div class="radio">
                                       <label>
                                          <input type="radio" name="niveau" value=<%=nq.getIdQualification() %> /><%=nq.getIntituleQualification() %>
                                       </label>
                                    </div>
                                 <% } %>
                              <%} %>
                           </small>
                    </div>
                </div>

                <div class="col-lg-9">
                                            <div class="form-group">
                                                <label>Secteur(s) d'activité</label>
                                                <small>
                                                    <table border="0" width="100%">
                                                        <!-- Un petit système à la volée pour mettre les checkboxes en deux colonnes...  -->
                                                        <%
                                                            int i=0;
                                                            for(SecteurActivite s : secteurActs) {
                                                                i++;
                                                                if(i%2 == 0) {
                                                                    if(candidat.getSecteurActivites() == s){ %>
                                                                       <div class="checkbox">
                                                                          <label>
                                                                             <td>
                                                                                <input type="checkbox" name="secteur" value=<%=s.getIdSecteur()%> /><%=s.getIntituleActivite()%>
                                                                             </td>
                                                                          </label>
                                                                       </div>
                                                                    <% }
                                                                    else{ %>
                                                                       <div class="checkbox">
                                                                          <label>
                                                                             <input type="radio" name="niveau" value=<%=nq.getIdQualification() %> /><%=nq.getIntituleQualification() %>
                                                                          </label>
                                                                       </div>
                                                                    <% } %>
                                                        </tr>
                                                        <%} else{%>
                                                        <tr>
                                                            if(candidat.getSecteurActivites() == s){ %>
                                                                <div class="checkbox">
                                                                    <label>
                                                                        <td>
                                                                           <input type="checkbox" name="secteur" value=<%=s.getIdSecteur()%> /><%=s.getIntituleActivite()%>
                                                                        </td>
                                                                    </label>
                                                                </div>
                                                            <% }
                                                            else{ %>
                                                                <div class="checkbox">
                                                                    <label>
                                                                        <td>
                                                                            <input type="radio" name="niveau" value=<%=nq.getIdQualification() %> /><%=nq.getIntituleQualification() %>
                                                                        </td>
                                                                    </label>
                                                                </div>
                                                            <%}
                                                        }
                                      		            if(i%2==1) { %>
                                                        </tr>
                                                        <% } %>
                                                    </table>
                                                </small>
                                            </div>
                                        </div>

                <div class="text-center">
                    <button type="submit" class="btn btn-success btn-circle btn-lg" name="submit"><i
                            class="fa fa-check"></i></button>
                    <button type="reset" class="btn btn-warning btn-circle btn-lg"><i class="fa fa-times"></i></button>
                </div>
            </form>
            <!-- --------------end modif -->
        </div>
        <%
        }
        %>

    </div> <!-- /#page-wrapper -->
</div> <!-- /#wrapper -->
<jsp:include page="fragments/fin_de_page.html"/>
</body>
</html>