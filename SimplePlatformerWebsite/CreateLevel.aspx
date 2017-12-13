<%@ Page Title="" Language="C#" MasterPageFile="~/Main.master" AutoEventWireup="true" CodeFile="CreateLevel.aspx.cs" Inherits="CreateLevel" %>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContentPlaceHolder" runat="Server">
    <div class="jumbotron" style="margin-top: 30px;">
        <h1>Создать новый уровень</h1>
        <p>Введите имя уровня и задайте его размеры</p>
        <form runat="server">
            <div class="form-group">
                <label>Название уровня</label>
                <asp:TextBox runat="server" ID="LevelNameTextBox" CssClass="form-control" />
                <asp:RequiredFieldValidator ID="LevelNameRequiredFieldValidator" runat="server" ErrorMessage="Название уровня обязательно" ControlToValidate="LevelNameTextBox"></asp:RequiredFieldValidator>
            </div>
            <div class="form-group">
                <label>Размер уровня в длину (X):</label>
                <asp:TextBox runat="server" ID="LevelXSizeTextBox" CssClass="form-control" />
                <asp:RequiredFieldValidator ID="LevelXSizeRequiredFieldValidator" runat="server" ErrorMessage="Ширина уровня обязательна" ControlToValidate="LevelXSizeTextBox"></asp:RequiredFieldValidator>
                <asp:CompareValidator ID="LevelXSizeCompareValidator" runat="server" ErrorMessage="Ширина уровня должна быть не менее 2" ControlToValidate="LevelXSizeTextBox" Type="Integer" Operator="GreaterThanEqual" ValueToCompare="2"></asp:CompareValidator>
            </div>
            <div class="form-group">
                <label>Размер уровня в высоту (Y):</label>
                <asp:TextBox runat="server" ID="LevelYSizeTextBox" CssClass="form-control" />
                <asp:RequiredFieldValidator ID="LevelYSizeRequiredFieldValidator" runat="server" ErrorMessage="Высота уровня обязательна" ControlToValidate="LevelYSizeTextBox"></asp:RequiredFieldValidator>
                <asp:CompareValidator ID="LevelYSizeCompareValidator" runat="server" ErrorMessage="Высота уровня должна быть не менее 2" ControlToValidate="LevelYSizeTextBox" Type="Integer" Operator="GreaterThanEqual" ValueToCompare="2"></asp:CompareValidator>
            </div>
            <asp:Button runat="server" CssClass="btn btn-primary btn-lg" Text="Создать уровень" />
            <asp:ValidationSummary ID="LevelValidationSummary" runat="server" style="margin-top: 20px;"/>
        </form>
    </div>
</asp:Content>

