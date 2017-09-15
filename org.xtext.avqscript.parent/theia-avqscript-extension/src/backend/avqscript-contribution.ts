import { createSocketConnection } from 'vscode-ws-jsonrpc/lib/server';
import * as path from 'path';
import * as net from 'net';

import { injectable, ContainerModule } from "inversify";
import { BaseLanguageServerContribution, LanguageServerContribution, IConnection } from "theia-core/lib/languages/node";

const LS_SERVER_JAR_PATH = path.resolve(__dirname, path.join('..', '..', '..', 'org.xtext.avqscript.ide', 'build', 'libs', 'avqscript-language-server.jar'));
const SOCKET_MODE = true;

export default new ContainerModule(bind => {
    bind<LanguageServerContribution>(LanguageServerContribution).to(AvqScriptServerContribution);
});

@injectable()
export class AvqScriptServerContribution extends BaseLanguageServerContribution {

    public id: string = 'avqscript';
    public name: string = 'AVQSCRIPT';

    start(clientConnection: IConnection): void {
        if (SOCKET_MODE) {
            const socket = new net.Socket();
            const serverConnection = createSocketConnection(socket, socket, () => {
                socket.destroy();
            });
            this.forward(clientConnection, serverConnection);
            socket.connect(5007);
        } else {
            const serverConnection = this.createProcessStreamConnection('java', 
                [   '-Xdebug', 
                    '-Xrunjdwp:server=y,transport=dt_socket,address=4000,suspend=n,quiet=y',
                    '-jar', LS_SERVER_JAR_PATH]);
            this.forward(clientConnection, serverConnection);
        }
    }

}