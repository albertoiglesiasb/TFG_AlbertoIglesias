$ProcessName = "xfoil"
$MaxTime = 15

while ($true) {
    # Obtener el proceso
    $process = Get-Process -Name $ProcessName -ErrorAction SilentlyContinue

    # Si el proceso está activo y ha excedido el tiempo máximo
    if ($process) {
        $runtime = (Get-Date) - $process.StartTime
        if ($runtime.TotalSeconds -ge $MaxTime) {
            # Finalizar el proceso
            Stop-Process -Name $ProcessName -Force
            Write-Output "$ProcessName ha sido finalizado después de $MaxTime segundos."
        }
    }

    # Esperar 1 segundos antes de verificar nuevamente
    Start-Sleep -Seconds 1
}