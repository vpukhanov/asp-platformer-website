<%@ Page Title="" Language="C#" MasterPageFile="~/Main.master" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="_Default" %>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContentPlaceHolder" runat="Server">
    <div class="page-header">
        <h1>Загрузить уровни</h1>
    </div>
    <asp:ListView ID="LevelsListView" runat="server" DataSourceID="LevelsSqlDataSource">
        <LayoutTemplate>
            <table class="table table-striped">
                <tr>
                    <th>#</th>
                    <th>Название</th>
                </tr>
                <tr runat="server" id="itemPlaceholder" />
            </table>
        </LayoutTemplate>
        <ItemTemplate>
            <tr>
                <td>
                    <asp:Label runat="server" ID="LevelIDLabel" Text='<%#Container.DisplayIndex + 1%>' />
                </td>
                <td>
                    <asp:HyperLink runat="server" ID="DownloadHyperLink" Text='<%#Eval("name") %>' NavigateUrl='<%#Eval("id", "~/DownloadLevel.aspx?id={0}") %>' />
                </td>
            </tr>
        </ItemTemplate>
    </asp:ListView>
    <asp:SqlDataSource ID="LevelsSqlDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:SimplePlatformerConnectionString %>" SelectCommand="SELECT [name], [id] FROM [levels]" />
</asp:Content>
