# El código siguiente, que crea un dataframe y quita las filas duplicadas, siempre se ejecuta y actúa como un preámbulo del script: 

# dataset = pandas.DataFrame(VIDEO_AD, TURNOVER)
# dataset = dataset.drop_duplicates()

# Pegue o escriba aquí el código de script:
import matplotlib.pyplot as plt
import matplotlib.patches as mpatches
import pandas as pd

dataset = dataset[['VIDEO_AD', 'TURNOVER']].dropna()

data_video = dataset[dataset['VIDEO_AD'] == True]['TURNOVER']
data_texto = dataset[dataset['VIDEO_AD'] == False]['TURNOVER']

def get_stats(data):
    return {
        'med': data.median(),
        'q1': data.quantile(0.25),
        'q3': data.quantile(0.75),
        'min': max(data.quantile(0.25) - 1.5*(data.quantile(0.75)-data.quantile(0.25)), data.min()),
        'max': min(data.quantile(0.75) + 1.5*(data.quantile(0.75)-data.quantile(0.25)), data.max())
    }

sv = get_stats(data_video)
st = get_stats(data_texto)

fig, ax = plt.subplots(figsize=(4, 5))
fig.patch.set_facecolor('white')
ax.set_facecolor('white')

def draw_box(ax, x, s, box_color, med_color, wh_color):
    ax.plot([x, x], [s['min'], s['q1']], color=wh_color, linewidth=1.2)
    ax.plot([x, x], [s['q3'], s['max']], color=wh_color, linewidth=1.2)
    ax.plot([x-0.06, x+0.06], [s['max'], s['max']], color=wh_color, linewidth=1.2)
    ax.plot([x-0.06, x+0.06], [s['min'], s['min']], color=wh_color, linewidth=1.2)
    rect = plt.Rectangle((x-0.14, s['q1']), 0.28, s['q3']-s['q1'],
                          facecolor=box_color, edgecolor='none', zorder=3)
    ax.add_patch(rect)
    ax.plot([x-0.14, x+0.14], [s['med'], s['med']],
            color=med_color, linewidth=2.5, zorder=4)

draw_box(ax, 0.28, sv, '#BFDBFE', '#2563EB', '#93C5FD')
draw_box(ax, 0.72, st, '#E5E7EB', '#6B7280', '#D1D5DB')

ymax = max(sv['max'], st['max'])
ymin = min(sv['min'], st['min'])
yrange = ymax - ymin

ax.text(0.28, ymax + yrange*0.04, 'VIDEO', ha='center', fontsize=9,
        fontweight='bold', color='#2563EB')
ax.text(0.72, ymax + yrange*0.04, 'TEXTO', ha='center', fontsize=9,
        fontweight='bold', color='#9CA3AF')

mid_med = (sv['med'] + st['med']) / 2
diff = int(sv['med'] - st['med'])
ax.text(0.5, mid_med + yrange*0.03, f'+EUR {diff}', ha='center', fontsize=9,
        fontweight='bold', color='#059669')
ax.text(0.5, mid_med - yrange*0.03, 'mediana', ha='center', fontsize=7,
        color='#111827')

ax.text(0.28, ymin - yrange*0.06,
        f'Med: EUR {int(sv["med"])}\nQ1:{int(sv["q1"])} Q3:{int(sv["q3"])}',
        ha='center', fontsize=7, color='#111827')
ax.text(0.72, ymin - yrange*0.06,
        f'Med: EUR {int(st["med"])}\nQ1:{int(st["q1"])} Q3:{int(st["q3"])}',
        ha='center', fontsize=7, color='#111827')

ax.set_xlim(0, 1)
ax.set_ylim(ymin - yrange*0.32, ymax + yrange*0.28)
ax.axis('off')
ax.text(0.5, ymin - yrange*0.28,
        'Escala IQR x1.5. Caja azul mas alta = mayor gasto en video',
        ha='center', fontsize=6.5, color='#111827', style='italic')
vip_count = int((dataset[dataset['VIDEO_AD'] == True]['TURNOVER'] > 400).sum())

vip_box = dict(boxstyle='round,pad=0.4', facecolor='#FEF3C7', edgecolor='#D97706', linewidth=1.2)
ax.text(0.5, ymax + yrange*0.18,
        f'VIP Video (EUR 400+): {vip_count} clientes',
        ha='center', fontsize=8, fontweight='bold', color='#92400E',
        bbox=vip_box)
plt.tight_layout()
plt.show()