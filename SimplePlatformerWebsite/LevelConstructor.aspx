<%@ Page Title="" Language="C#" MasterPageFile="~/Main.master" AutoEventWireup="true" CodeFile="LevelConstructor.aspx.cs" Inherits="LevelConstructor" %>

<asp:Content ID="Content1" ContentPlaceHolderID="StylesPlaceHolder" runat="Server">
    <style>
        #levelEditorTable {
            border-collapse: collapse;
        }

        td.editorCell {
            width: 30px;
            height: 30px;
        }

        .emptyCell {
            background-color: white;
        }

        .playerCell {
            background-color: green;
        }

        .gemCell {
            background-color: goldenrod;
        }

        .exitCell {
            background-color: red;
        }

        .groundCell {
            background-color: black;
        }

        .aspHidden {
            display: none;
        }

        .btnmargin {
            margin-top: 20px;
            margin-bottom:  20px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContentPlaceHolder" runat="Server">
    <div class="page-header">
        <h1>Конструктор уровня <small><asp:Label runat="server" ID="LevelDataLabel" /></small></h1>
    </div>
    <form runat="server">
        <div id="levelEditor">
            <table id="levelEditorTable" border="1">
            </table>
        </div>
        <div style="position: fixed; left: 20px; top: 160px; background-color: white; border: 2px dashed black; padding: 15px;">
            Выберите режим ввода:<br />
            <input type="radio" name="inputMode" id="inputModeGround" checked /> Земля<br />
            <input type="radio" name="inputMode" id="inputModeGem" /> Ценность<br />
            <input type="radio" name="inputMode" id="inputModePlayer" /> Игрок<br />
            <input type="radio" name="inputMode" id="inputModeExit" /> Выход
        </div>
        <asp:TextBox runat="server" ID="LevelNameTextBox" Visible="False" />
        <asp:TextBox runat="server" ID="LevelYSizeTextBox" Visible="False" />
        <asp:TextBox runat="server" ID="LevelDataTextBox" ClientIDMode="Static" CssClass="aspHidden" />
        <asp:Button runat="server" ID="SaveLevelButton" Text="Сохранить уровень" CssClass="btn btn-success btn-lg btnmargin" OnClick="SaveLevelButton_Click" />
    </form>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ScriptsPlaceHolder" runat="Server">
    <asp:Literal runat="server" ID="VariablesLiteral" />
    <script>
        // Заданы levelName, xSize и ySize
        var
            EMPTY = 0, GROUND = 1, GEM = 2, PLAYER = 4, EXIT = 8,
            inputMode = GROUND,
            editorTable = document.querySelector('#levelEditorTable'),
            resultInput = document.querySelector('#LevelDataTextBox'),
            levelMatrix = [];

        // Создаем таблицу и матрицу
        for (var y = ySize - 1; y >= 0; y--) {
            var newRow = document.createElement('tr');
            levelMatrix.push([]);
            for (var x = 0; x < xSize; x++) {
                var newCell = document.createElement('td');
                newCell.className = 'editorCell emptyCell';
                newCell.id = 'cell-' + x + '-' + y;
                newRow.appendChild(newCell);
                levelMatrix[levelMatrix.length - 1].push(0);
            }
            editorTable.appendChild(newRow);
        }

        // На карте всегда должны присутствовать игрок и выход
        levelMatrix[0][0] = PLAYER;
        levelMatrix[0][1] = EXIT;
        $('#cell-0-' + (ySize - 1)).removeClass('emptyCell');
        $('#cell-0-' + (ySize - 1)).addClass('playerCell');
        $('#cell-1-' + (ySize - 1)).removeClass('emptyCell');
        $('#cell-1-' + (ySize - 1)).addClass('exitCell');

        // Заполняем пустой input
        function updateResultInput() {
            resultInput.value = levelMatrix.map(row => row.join('')).join(',');
        }
        updateResultInput();

        // Обработчики смены режимов
        $('#inputModeGround').click(function () {
            inputMode = GROUND;
        });
        $('#inputModeGem').click(function () {
            inputMode = GEM;
        });
        $('#inputModePlayer').click(function () {
            inputMode = PLAYER;
        });
        $('#inputModeExit').click(function () {
            inputMode = EXIT;
        });

        function findIdByMode(mode) {
            for (var row = 0; row < ySize; row++)
                for (var col = 0; col < xSize; col++)
                    if (levelMatrix[row][col] == mode)
                        return 'cell-' + col + '-' + (ySize - row - 1);
        }
        function getCoordsById(id) {
            var split = id.split('-');
            return { x: +split[1], y: +split[2] };
        }
        function getValueById(id) {
            var coords = getCoordsById(id);
            return levelMatrix[ySize - coords.y - 1][coords.x];
        }
        function setValueById(id, value) {
            var coords = getCoordsById(id);

            levelMatrix[ySize - coords.y - 1][coords.x] = value;

            var className = '';
            switch (value) {
                case EMPTY:
                    className = 'emptyCell';
                    break;
                case GROUND:
                    className = 'groundCell';
                    break;
                case GEM:
                    className = 'gemCell';
                    break;
                case PLAYER:
                    className = 'playerCell';
                    break;
                case EXIT:
                    className = 'exitCell';
                    break;
            }

            $('#' + id).removeClass();
            $('#' + id).addClass('editorCell ' + className);
        }

        // Обработчик клика по ячейке
        $('.editorCell').click(function () {
            // Не даем перезаписывать клетки выхода и игрока
            var currentValue = getValueById(this.id);
            if (currentValue == PLAYER || currentValue == EXIT)
                return;

            if (inputMode == PLAYER || inputMode == EXIT) {
                var oldId = findIdByMode(inputMode);
                setValueById(oldId, EMPTY);
                setValueById(this.id, inputMode);
            } else {
                setValueById(this.id, inputMode);
            }
            updateResultInput();
        });

        // Обработчик удаления ячейки
        $('.editorCell').contextmenu(function (e) {
            e.preventDefault();

            var currentValue = getValueById(this.id);
            if (currentValue == GROUND || currentValue == GEM) {
                setValueById(this.id, EMPTY);
            }

            updateResultInput();
        });
    </script>
</asp:Content>

