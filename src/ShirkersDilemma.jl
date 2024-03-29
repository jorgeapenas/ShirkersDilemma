module ShirkersDilemma

using Distributions, Roots
using Plots, LaTeXStrings, ColorSchemes

greet() = print("Hello World!")

### Preliminary functions ###

# probability that there are at most ζ shirkers in a group (Eq. 2)
Πζn(q,ζ,n) = Distributions.cdf(Binomial(n,q),ζ)

# pivot probability (Eq. 7)
πζn(q,ζ,n) = Distributions.pdf(Binomial(n-1,q),ζ)

# critical cost (Eq. 9)
cbar(ζ,n) = πζn(ζ/(n-1),ζ,n)

# maximum critical cost (Eq. 15)
cdagger(ζ) = (ζ/(ζ+1))^ζ 

# probability mass function of a Poisson distribution with parameter λ (Eq. 17)
ρ(k,λ) = Distributions.pdf(Poisson(λ),k)

# limit critical cost (Eq. 16)
cbarstar(ζ) = ρ(ζ,ζ)

# unstable interior rest point (larger solution of the pivotality condition, Eq. 8)
function quζc(n,ζ,c)
    if c >= cbar(ζ,n)
        return NaN
    else
        g(q) = c - πζn(q,ζ,n) # gain function (Eq. 6)
        return find_zero(g,(ζ/(n-1),1))
    end
end

# stable interior rest point (smaler solution of the pivotality condition, Eq. 8)
function qsζc(n,ζ,c)
    if c >= cbar(ζ,n)
        return NaN
    else
        g(q) = c - πζn(q,ζ,n) # gain function (Eq. 5)
        return find_zero(g,(0,ζ/(n-1)))
    end
end

# minimal rest point (Eq. 10)
function qζc(n,ζ,c)
    if c >= cbar(ζ,n)
        return 1.
    else
        return qsζc(n,ζ,c)
    end
end

# proportion of volunteers at the minimal rest point (Eq. 11)
pζc(n,ζ,c) = 1 - qζc(n,ζ,c)

# expected payoff at the minimal rest point (Eq. 13)
uζc(n,ζ,c) = Πζn(qζc(n,ζ,c),ζ-1,n-1)

# success probability at the minimal rest point (Eq. 12)
ϕζc(n,ζ,c) = Πζn(qζc(n,ζ,c),ζ,n)

# expected number of co-players that are shirkers at the minimal rest point (first eq. in appendix A.5)
λζc(n,ζ,c) = (n-1)*qζc(n,ζ,c)

# expected number of group members that are shirkers at the minimal rest point (Eq. 24)
μζc(n,ζ,c) = n*qζc(n,ζ,c)

# limit expected number of co-players that are shirkers at the minimal rest point
# (second eq. in appendix A.5, see also Lemma 4)
function λζcstar(ζ,c)
    if c > cbarstar(ζ)
        return Inf
    else
        f(λ) = ρ(ζ,λ) - c
        return find_zero(f,(0,ζ))
    end
end

# limit expected number of group members that are shirkers at the minimal rest point
# (see Lemma 4)
μζcstar(ζ,c) = λζcstar(ζ,c)

# cumulative distribution function of a Poisson distribution with parameter λ
# (second eq. in Proposition 4)
P(k,λ) = Distributions.cdf(Poisson(λ),k)

# limit proportion of volunteers at the minimal rest point (Eq. 26)
function pζcstar(ζ,c)
	if c > cbarstar(ζ)
        return 0.
    else 
		return 1.
	end
end

# limit expected payoff at the minimal rest point (Eq. 26, see also appendix A.5)
function uζcstar(ζ,c)
	if c > cbarstar(ζ)
		return 0.
	else
		return P(ζ-1,μζcstar(ζ,c))
	end
end

# limit success probability at the minimal rest point (Eq. 26, see also appendix A.5)
function ϕζcstar(ζ,c)
	if c > cbarstar(ζ)
        return 0.
    else 
		return P(ζ,μζcstar(ζ,c))
	end
end

### Figures ###

# colors
colorname(c) = string("#",hex(c))
blue = colorname(ColorSchemes.seaborn_colorblind[1])
yellow = colorname(ColorSchemes.seaborn_colorblind[2])
green = colorname(ColorSchemes.seaborn_colorblind[3])
red = colorname(ColorSchemes.seaborn_colorblind[4])
purple = colorname(ColorSchemes.seaborn_colorblind[5])
pink = colorname(ColorSchemes.seaborn_colorblind[7])
gray = colorname(ColorSchemes.seaborn_colorblind[8])
markershapes = [:circle, :rect, :star5, :diamond, :hexagon, :cross, :xcross, :utriangle, :dtriangle, :rtriangle]

# Fig. 1 (pivot probability and evolutionary dynamics)
function plot_pivot_dynamics(ζ,n)

    eps_arrows = 0.03

	pl_pivot_dynamics = plot(layout=(2,2),framestyle=:box,xlims=(-0.05,1.05),ylims=(0,1))
	
	q = range(0,stop=1,length=1000)
	y = πζn.(q,ζ,n)
	qhat = ζ/(n-1)
	cb = cbar(ζ,n)

	# subplot 1
	
	plot!(subplot=1,q,y,color=blue,label=false) # pivot probability
	plot!(subplot=1,xticks=([0,qhat,1],[L"0", L"\frac{\zeta}{n-1}",L"1"]))
	plot!(subplot=1,yticks=([0,cb,1], [L"0", L"\bar{c}_{\zeta,n}",L"1"]))	
	plot!(subplot=1,[0;qhat],[cb;cb],color=blue,linestyle=:dash,label=false)
	plot!(subplot=1,[qhat;qhat],[0;cb],color=blue,linestyle=:dash,label=false)
	plot!(subplot=1,ylabel=L"\textrm{pivot \ probability,} \ \pi_{\zeta,n}(q)",ylabelfontsize=8)

	# subplot 2

	c1 = 0.6 # cost

	plot!(subplot=2,q,y,color=blue,label=false) # pivot probability
	plot!(subplot=2,q,y,color=blue,label=false)
	plot!(subplot=2,[0;1],[c1;c1],color=gray,label=false)
	plot!(subplot=2,[0],[c1],markershape=:circle,markersize=5,color=red,markerstrokecolor=red,label=false)
	plot!(subplot=2,[0],[c1],markershape=:circle,markersize=3,color="white",markerstrokecolor="white",label=false)
	plot!(subplot=2,[1],[c1],markershape=:circle,markersize=5,color=red,markerstrokecolor=red,label=false)
	plot!(subplot=2,[0+eps_arrows;1-eps_arrows],[c1+eps_arrows;c1+eps_arrows],color="black",arrow=true,label=false)	
	plot!(subplot=2,xticks=([0,qhat,1],[L"0", L"\frac{\zeta}{n-1}",L"1"]))
	plot!(subplot=2,yticks=([0,cb,c1,1], [L"0",L"\bar{c}_{\zeta,n}",L"c",L"1"]))

	# subplot 3

	plot!(subplot=3,q,y,color=blue,label=false)
	plot!(subplot=3,[0;1],[cb;cb],color=gray,label=false)
	plot!(subplot=3,[0],[cb],markershape=:circle,markersize=5,color=red,markerstrokecolor=red,label=false)
	plot!(subplot=3,[0],[cb],markershape=:circle,markersize=3,color="white",markerstrokecolor="white",label=false)
	plot!(subplot=3,[1],[cb],markershape=:circle,markersize=5,color=red,markerstrokecolor=red,label=false)
	plot!(subplot=3,[qhat],[cb],markershape=:circle,markersize=5,color=red,markerstrokecolor=red,label=false)
	plot!(subplot=3,[qhat],[cb],markershape=:circle,markersize=3,color="white",markerstrokecolor="white",label=false)
	plot!(subplot=3,[0+eps_arrows;qhat-eps_arrows],[cb+eps_arrows;cb+eps_arrows],color="black",arrow=true,label=false)
	plot!(subplot=3,[qhat+eps_arrows;1-eps_arrows],[cb+eps_arrows;cb+eps_arrows],color="black",arrow=true,label=false)		
	plot!(subplot=3,xticks=([0,qhat,1],[L"0",L"\frac{\zeta}{n-1}",L"1"]))
	plot!(subplot=3,yticks=([0,cb,1], [L"0",L"\bar{c}_{\zeta,n}",L"1"]))
	plot!(subplot=3,xlabel=L"\textrm{proportion \ of \ shirkers,} \ q",xlabelfontsize=8)
	plot!(subplot=3,ylabel=L"\textrm{pivot \ probability,} \ \pi_{\zeta,n}(q)",ylabelfontsize=8)

	# subplot 4

	c2 = 0.3 # cost

	qs2 = qζc(n,ζ,c2)
	qu2 = quζc(n,ζ,c2)

	plot!(subplot=4,q,y,color=blue,label=false) # pivot probability
	plot!(subplot=4, framestyle=:box) # box around plot
	plot!(subplot=4,[0; 1],[c2; c2],color=gray,label=false) # horizontal line cost

	# trivial rest point q=0
	plot!(subplot=4,[0],[c2],markershape=:circle,markersize=5,color=red,markerstrokecolor=red,label=false)
	plot!(subplot=4,[0],[c2],markershape=:circle,markersize=3,color="white",markerstrokecolor="white",label=false)

	#  unstable interior rest point
	plot!(subplot=4,[qu2],[c2],markershape=:circle,markersize=5,color=red,markerstrokecolor=red,label=false)
	plot!(subplot=4,[qu2],[c2],markershape=:circle,markersize=3,color="white",markerstrokecolor="white",label=false)

	# stable interior rest point
	plot!(subplot=4,[qs2],[c2],markershape=:circle,markersize=5,color=red,markerstrokecolor=red,label=false)

	# trivial rest point q=1
	plot!(subplot=4,[1],[c2],markershape=:circle,markersize=5,color=red,markerstrokecolor=red,label=false)

	# dynamics arrows
	plot!(subplot=4,[0+eps_arrows;qs2-eps_arrows],[c2+eps_arrows;c2+eps_arrows],color="black",arrow=true,label=false)
	plot!(subplot=4,[qu2-eps_arrows;qs2+eps_arrows],[c2+eps_arrows;c2+eps_arrows],color="black",arrow=true,label=false)		
	plot!(subplot=4,[qu2+eps_arrows;1-eps_arrows],[c2+eps_arrows;c2+eps_arrows],color="black",arrow=true,label=false)			
	
	plot!(subplot=4,xticks = ([0,qu2,qhat,qs2,1], [L"0",L"q^u_{\zeta,c}",L"\frac{\zeta}{n-1}",L"q^s_{\zeta,c}",L"1"]))
	plot!(subplot=4,yticks = ([0,c2,cb,1], [L"0",L"c",L"\bar{c}_{\zeta,n}",L"1"]))

	plot!(subplot=4,xlabel=L"\textrm{proportion \ of \ shirkers,} \ q",xlabelfontsize=8)

	plot!(size=(600,400))

    return pl_pivot_dynamics
	
end

# Fig. 2 (critical costs)
function plot_critical_costs(nmax,ζmax)

	pl_critical_costs = plot(layout=(1,2))

	# subplot 1
	plot!(subplot=1,legend=:bottomleft,ylims=(0,.52))
	
	for ζ in 1:4
		n = range(ζ+2,stop=nmax)
		cb = cbar.(ζ,n)
		cbs = cbarstar(ζ)
		color = colorname(ColorSchemes.seaborn_colorblind[ζ])
		plot!(subplot=1,n,cb,markershape=markershapes[ζ],markersize=5,color=color,label="\$\\bar{c}_{$ζ,n}\$")
		plot!(subplot=1,3:nmax,cbs*ones(length(3:nmax)),color=color,linestyle=:dash,label=false) # label="\$\\bar{c}_$ζ^*\$"
	end

	plot!(subplot=1,xlabel=L"\textrm{group \ size,} \ n") 
	plot!(subplot=1,ylabel=L"\textrm{cost,} \ c")

	# subplot 2
	plot!(subplot=2,legend=:right,ylims=(0,.52),xaxis=:log)

	ζs = range(1,stop=ζmax)

	cbarstars = cbarstar.(ζs) 
	cdaggers = cdagger.(ζs)

	plot!(subplot=2,ζs,cdaggers,markershape=:circle,markersize=5,color=colorname(ColorSchemes.seaborn_colorblind[5]),label="\$\\bar{c}_\\zeta^\\dagger\$")
	plot!(subplot=2,ζs,cbarstars,markershape=:square,markersize=5,color=colorname(ColorSchemes.seaborn_colorblind[6]),label="\$\\bar{c}_\\zeta^*\$")	
	
	plot!(subplot=2,xticks=([1,5,10,30],[1,5,10,30]))
	
	plot!(subplot=2,xlabel=L"\textrm{threshold,} \ \zeta")

	plot!(size=(600,300))
    
    return pl_critical_costs
	
end

# Fig. 3 (illustration of Lemma 3; group size effects on pivot probabilities)
function plot_group_size_effect_on_pivot_probability(ζ,n,c)

	q = range(0,stop=1,length=1000)
	y = πζn.(q,ζ,n)
	qhat = ζ/(n-1)
	cb = cbar(ζ,n)
	qs = qζc(n,ζ,c)
	qu = quζc(n,ζ,c)

	yy = πζn.(q,ζ,n+1)
	qqhat = ζ/n
	ccb = cbar(ζ,n+1)
	qqs = qζc(n+1,ζ,c)
	qqu = quζc(n+1,ζ,c)

	pl_pivots = plot(layout=(1,1),framestyle=:box,xlims=(-0.05,1.05),ylims=(-0.05,1.05))

	# horizontal line cost
	plot!([0; 1],[c; c],color=gray,linewidth=3,label=false)
	 
	# horizontal line critical cost n
	plot!([0; qhat],[cb; cb],color=gray,linestyle=:dash,linewidth=2,label=false)

	# vertical line critical cost n
	plot!([qhat; qhat],[0; cb],color=gray,linestyle=:dash,linewidth=2,label=false)

	# pivot probability n
	plot!(q,y,color=blue,linestyle=:dash,linewidth=3,label=L"\ \pi_{\zeta,n}(q)")

	# stable interior rest point n
	plot!([qs],[c],markershape=:circle,markersize=10,color=red,alpha=0.5,markerstrokecolor=red,label=false)

	#  unstable interior rest point n
	plot!([qu],[c],markershape=:circle,markersize=10,alpha=0.5,color=red,markerstrokecolor=red,label=false)
	plot!([qu],[c],markershape=:circle,markersize=7,alpha=1.0,color="white",markerstrokecolor="white",label=false)

	# pivot probability n+1
	plot!(q,yy,color=blue,linewidth=3,label=L"\ \pi_{\zeta,n+1}(q)")

	# horizontal line critical cost n
	plot!([0; qqhat],[ccb; ccb],color=gray,linestyle=:dash,linewidth=2,label=false)

	# vertical line critical cost n
	plot!([qqhat; qqhat],[0; ccb],color=gray,linestyle=:dash,linewidth=2,label=false)

	# stable interior rest point n+1
	plot!([qqs],[c],markershape=:circle,markersize=10,color=red,markerstrokecolor=red,label=false)

	#  unstable interior rest point n+1
	plot!([qqu],[c],markershape=:circle,markersize=10,color=red,markerstrokecolor=red,label=false)
	plot!([qqu],[c],markershape=:circle,markersize=7,color="white",markerstrokecolor="white",label=false)

	plot!(xrotation=90,xticks=([0,qhat,qqhat,qs,qqs,qu,qqu,1], [L"0",L"\frac{\zeta}{n-1}",L"\frac{\zeta}{n}",L"q^s_{\zeta,c}(n)",L"q^s_{\zeta,c}(n+1)",L"q^u_{\zeta,c}(n)",L"q^u_{\zeta,c}(n+1)",L"1"]))
	plot!(yticks = ([0,c,cb,ccb,1], [L"0",L"c",L"\bar{c}_{\zeta,n}",L"\bar{c}_{\zeta,n+1}",L"1"]))
	
	plot!(xlabel=L"\textrm{proportion \ of \ shirkers,} \ q")
	plot!(ylabel=L"\textrm{pivot \ probability}")

	plot!(framestyle=:box) # box around plot
	plot!(xlabelfontsize=10,ylabelfontsize=10,tickfontsize=10,legendfontsize=10,bottom_margin=5Plots.mm)

	plot!(size=(600,400))

	return pl_pivots
end

# Fig. 4, left panel (proportion of volunteers as a function of group size)
function plot_p(nmax,c)
	pl_p = plot(legend=:right)
	for ζ in 1:5
		n = range(ζ+2,stop=nmax)
		p = pζc.(n,ζ,c)
		color = colorname(ColorSchemes.seaborn_colorblind[ζ])
		plot!(n,p,ylims=(-0.05,1.0),markershape=markershapes[ζ],markersize=3,legend=:bottomleft,legendfontsize=5,color=color,label="\$\\zeta=$ζ\$")
	end
	plot!(xlabel=L"\textrm{group \ size,} \ n") 
	plot!(ylabel=L"\textrm{proportion \ of \ volunteers,} \ p_{\zeta,c}(n)")
    return pl_p
end

# Fig. 4, right panel (expected payoff as a function of group size)
function plot_u(nmax,c)
	pl_u = plot(legend=:bottomleft)
	for ζ in 1:5
		n = range(ζ+2,stop=nmax)
		u = uζc.(n,ζ,c)
		color = colorname(ColorSchemes.seaborn_colorblind[ζ])
		plot!(n,u,ylims=(-0.05,1.0),markershape=markershapes[ζ],markersize=3,legend=false,color=color,label="\$\\zeta=$ζ\$")
	end
	plot!(xlabel=L"\textrm{group \ size,} \ n") 
	plot!(ylabel=L"\textrm{expected \ payoff,} \ u_{\zeta,c}(n)")
    return pl_u
end

# Fig. 5 (heatmap proportion of volunteers)
function plot_p_heatmap(nmax)
	pl_p_heatmap = plot(layout=(2,2))
	color_heatmap =:viridis
	for ζ in 1:4
		ns_heatmap = range(ζ+2,stop=nmax)
		cs_heatmap = range(0.01,0.5,step=0.01)
		p_heatmap = zeros(length(cs_heatmap),length(ns_heatmap))
		for i in 1:length(ns_heatmap)
			for j in 1:length(cs_heatmap)
				p_heatmap[j,i] = pζc(ns_heatmap[i],ζ,cs_heatmap[j])
			end
		end
		heatmap!(subplot=ζ,ns_heatmap,cs_heatmap,p_heatmap,xlims=(3,nmax),clim=(0,1),c=color_heatmap,legend_title_font_halign=:left,legend_title_font_pointsize=10,legend_title=" \$\\zeta=$ζ\$")
		plot!(subplot=ζ,[ζ+2, nmax],[cdagger(ζ), cdagger(ζ)],linewidth=2,color="red",linestyle=:solid,label="")
		plot!(subplot=ζ,[ζ+2, nmax],[cbarstar(ζ), cbarstar(ζ)],linewidth=2,color="red",linestyle=:dash,label="")
	end
	plot!(subplot=3,xlabel=L"\textrm{group \ size,} \ n")
	plot!(subplot=4,xlabel=L"\textrm{group \ size,} \ n")	
	plot!(subplot=1,ylabel=L"\textrm{cost,} \ c") 
	plot!(subplot=3,ylabel=L"\textrm{cost,} \ c") 
    return pl_p_heatmap 
end

# Fig. 6 (heatmap basin of attraction stable equilibrium)
function plot_basin_heatmap(nmax)
    pl_basin_heatmap = plot(layout=(2,2))
	color_heatmap = :viridis
	for ζ in 1:4
		ns_heatmap = range(ζ+2,stop=nmax)
		cs_heatmap = range(0.01,0.5,step=0.01)
		basin_heatmap = zeros(length(cs_heatmap),length(ns_heatmap))
		for i in 1:length(ns_heatmap)
			for j in 1:length(cs_heatmap)
				basin_heatmap[j,i] = quζc(ns_heatmap[i],ζ,cs_heatmap[j])
			end
		end
		heatmap!(subplot=ζ,ns_heatmap,cs_heatmap,basin_heatmap,xlims=(3,nmax),clim=(0,1),c=color_heatmap,legend_title_font_halign=:left,legend_title_font_pointsize=10,legend_title=" \$\\zeta=$ζ\$")
		contour!(subplot=ζ,ns_heatmap,cs_heatmap,basin_heatmap,xlims=(3,nmax),levels=[0.5],linewidth=2,color="red",linestyle=:solid)
	end
	plot!(subplot=3,xlabel=L"\textrm{group \ size,} \ n")
	plot!(subplot=4,xlabel=L"\textrm{group \ size,} \ n")	
	plot!(subplot=1,ylabel=L"\textrm{cost,} \ c") 
	plot!(subplot=3,ylabel=L"\textrm{cost,} \ c")
    return pl_basin_heatmap 	
end

# Fig. 7 (heatmap expected payoff)
function plot_u_heatmap(nmax)
	pl_u_heatmap = plot(layout=(2,2))
	color_heatmap = :viridis
	for ζ in 1:4
		ns_heatmap = range(ζ+2,stop=nmax)
		cs_heatmap = range(0.01,0.5,step=0.01)
		u_heatmap = zeros(length(cs_heatmap),length(ns_heatmap))
		for i in 1:length(ns_heatmap)
			for j in 1:length(cs_heatmap)
				u_heatmap[j,i] = uζc(ns_heatmap[i],ζ,cs_heatmap[j])
			end
		end
		heatmap!(subplot=ζ,ns_heatmap,cs_heatmap,u_heatmap,xlims=(3,nmax),clim=(0,1),c=color_heatmap,legend_title_font_halign=:left,legend_title_font_pointsize=10,legend_title=" \$\\zeta=$ζ\$")
		plot!(subplot=ζ,[ζ+2, nmax],[cdagger(ζ), cdagger(ζ)],linewidth=2,color="red",linestyle=:solid,label="")
		plot!(subplot=ζ,[ζ+2, nmax],[cbarstar(ζ), cbarstar(ζ)],linewidth=2,color="red",linestyle=:dash,label="")
	end
	plot!(subplot=3,xlabel=L"\textrm{group \ size,} \ n")
	plot!(subplot=4,xlabel=L"\textrm{group \ size,} \ n")	
	plot!(subplot=1,ylabel=L"\textrm{cost,} \ c") 
	plot!(subplot=3,ylabel=L"\textrm{cost,} \ c")
    return pl_u_heatmap 	 	
end

# Fig. 8, right panel (success probability as a function of group size)
function plot_ϕ(nmax,c)
	pl_phi = plot(legend=:bottomleft)
	for ζ in 1:5
		n=range(ζ+2,stop=nmax)
		ϕ = ϕζc.(n,ζ,c)
		color = colorname(ColorSchemes.seaborn_colorblind[ζ])
		plot!(n,ϕ,markershape=markershapes[ζ],markersize=3,legendfontsize=5,color=color,label="\$\\zeta=$ζ\$")
	end
	plot!(xlabel=L"\textrm{group \ size,} \ n") 
	plot!(ylabel=L"\textrm{success \ probability,} \phi_{\zeta,c}(n)")
	plot!(markersize=1)
    return pl_phi
end

# Fig. 8, left panel (success probability as a function of group size)
function plot_ϕ_2()
	pl_phi_2 = plot()
	ns = range(3,stop=10)
	cs = [0.305, 0.3075, 0.31]
	for i in 1:length(cs)
		c = cs[i]
		ϕ = ϕζc.(ns,1,c)
		color = colorname(ColorSchemes.seaborn_colorblind[i])
		plot!(ns,ϕ,markershape=markershapes[i],markersize=3,legend=:topright,legendfontsize=5,color=color,label="\$c=$c\$")
	end
	plot!(xlabel=L"\textrm{group \ size,} \ n") 
	plot!(ylabel=L"\textrm{success \ probability,} \phi_{1,c}(n)")
    return pl_phi_2
end

# Fig. 9 (heatmap success probability)
function plot_ϕ_heatmap(nmax)
	pl_phi_heatmap = plot(layout=(2,2),link=:all)
	color_heatmap = :viridis
	for ζ in 1:4
		ns_heatmap=range(ζ+2,stop=nmax)
		cs_heatmap=range(0.01,0.5,step=0.01)
		phi_heatmap = zeros(length(cs_heatmap),length(ns_heatmap))
		for i in 1:length(ns_heatmap)
			for j in 1:length(cs_heatmap)
				phi_heatmap[j,i] = ϕζc(ns_heatmap[i],ζ,cs_heatmap[j])
			end
		end
		heatmap!(subplot=ζ,ns_heatmap,cs_heatmap,phi_heatmap,xlims=(3,nmax),clim=(0,1),c=color_heatmap,legend_title_font_halign=:left,legend_title_font_pointsize=10,legend_title=" \$\\zeta=$ζ\$")
		plot!(subplot=ζ,[ζ+2, nmax],[cdagger(ζ), cdagger(ζ)],linewidth=2,color="red",linestyle=:solid,label="")
		plot!(subplot=ζ,[ζ+2, nmax],[cbarstar(ζ), cbarstar(ζ)],linewidth=2,color="red",linestyle=:dash,label="")
	end
	plot!(subplot=3,xlabel=L"\textrm{group \ size,} \ n")
	plot!(subplot=4,xlabel=L"\textrm{group \ size,} \ n")	
	plot!(subplot=1,ylabel=L"\textrm{cost,} \ c") 
	plot!(subplot=3,ylabel=L"\textrm{cost,} \ c")
    return pl_phi_heatmap  	
end

# Fig. 10, top left (poisson pivot probability)
function plot_pivot_Poisson(ζ,c)

	pl_pivot_Poisson = plot(framestyle=:box,ylims=(0,1))
	
	λmax = 2*ζ+1
	λs = range(0,λmax,length=1000)
	ρs = ρ.(ζ,λs)
	phis_Poisson = P.(ζ,λs)
	us_Poisson = P.(ζ,λs) .- c
	
	plot!(λs,ρs,color=blue,linewidth=3,label="\$\\rho_{\\zeta}(\\lambda)\$") # pivot probability
	plot!([0;ζ],[cbarstar(ζ);cbarstar(ζ)],color=blue,linewidth=2,linestyle=:dash,label=false)
	plot!([ζ;ζ],[0;cbarstar(ζ)],color=blue,linewidth=2,linestyle=:dash,label=false)

	plot!([0; λmax],[c; c],color=gray,linewidth=3,label=false) # horizontal line cost
	plot!([μζcstar(ζ,c);μζcstar(ζ,c)],[0;c],color=gray,linewidth=2,linestyle=:dash,label=false)
	plot!([μζcstar(ζ,c)],[c],markersize=8,color=blue,markerstrokecolor=blue,markershape=:circle,label=false)

	plot!(λs,us_Poisson,color=red,linewidth=3,label="\$P_{\\zeta}(\\lambda) - c\$")
	plot!([μζcstar(ζ,c);μζcstar(ζ,c)],[0;uζcstar(ζ,c)],color=gray,linewidth=2,linestyle=:dash,label=false)
	plot!([0;μζcstar(ζ,c)],[uζcstar(ζ,c);uζcstar(ζ,c)],color=red,linewidth=2,linestyle=:dash,label=false)	

	plot!(λs,phis_Poisson,color=green,linewidth=3,label="\$P_{\\zeta}(\\lambda)\$")
	plot!([μζcstar(ζ,c);μζcstar(ζ,c)],[0;ϕζcstar(ζ,c)],color=gray,linewidth=2,linestyle=:dash,label=false)
	plot!([0;μζcstar(ζ,c)],[ϕζcstar(ζ,c);ϕζcstar(ζ,c)],color=green,linewidth=2,linestyle=:dash,label=false)
	
	plot!(xticks=([0,μζcstar(ζ,c),ζ],[L"0",L"\mu_{\zeta,c}^*",L"\zeta"]))
	plot!(yticks=([0,cbarstar(ζ),uζcstar(ζ,c),ϕζcstar(ζ,c),1], [L"0", L"\bar{c}_{\zeta}^*",L"u_{\zeta,c}^*",L"\phi_{\zeta,c}^*",L"1"]))	
	
	plot!(xlabel=L"\textrm{expected \ number \ of \ (other) \ shirkers}",xlabelfontsize=8)	
	plot!(ylabel=L"\textrm{probability}",ylabelfontsize=8)

    return pl_pivot_Poisson
	
end

# Fig. 10 top right (limit proportion of volunteers)
function plot_limit_p()
	pl_limit_p = plot(ylims=(0.,1.05))
	cs_limits = range(eps(),0.5-eps(),length=1500)
	for ζ in 1:4
		pstars = pζcstar.(ζ,cs_limits)
		replace!(pstars,0=>NaN)
		color = colorname(ColorSchemes.seaborn_colorblind[ζ])
		plot!(cs_limits,pstars,color=color,linewidth=2,label="\$\\zeta=$ζ\$")
		plot!([cbarstar(ζ);cbarstar(ζ)],[0;1],color=color,linewidth=2,linestyle=:dash,label=false)
		plot!([cbarstar(ζ);0.5],[0,0],linewidth=2,color=color,label=false)
	end
	plot!(xlabel=L"\textrm{cost,} \ c",xlabelfontsize=7)
	plot!(ylabel=L"\textrm{limit \ proportion \ of \ volunteers,} p_{\zeta,c}^*",ylabelfontsize=7)
    return pl_limit_p
end

# Fig. 10 bottom left (limit expected payoff)
function plot_limit_u()
	pl_limit_u = plot(ylims=(0.,1.05))
    cs_limits = range(eps(),0.5-eps(),length=1500)
	for ζ in 1:4
		ustars = uζcstar.(ζ,cs_limits)
		replace!(ustars,0=>NaN)
		color = colorname(ColorSchemes.seaborn_colorblind[ζ])
		plot!(cs_limits,ustars,color=color,linewidth=2,label="\$\\zeta=$ζ\$")
		plot!([cbarstar(ζ);cbarstar(ζ)],[0;uζcstar.(ζ,cbarstar(ζ)-eps())],color=color,linewidth=2,linestyle=:dash,label=false)
		plot!([cbarstar(ζ);0.5],[0,0],linewidth=2,color=color,label=false)
	end
	plot!(xlabel=L"\textrm{cost,} \ c",xlabelfontsize=7)
	plot!(ylabel=L"\textrm{limit \ expected \ payoff,} u_{\zeta,c}^*",ylabelfontsize=7)
    return pl_limit_u
end

# Fig. 10 bottom right (limit success probability)
function plot_limit_ϕ()
	pl_limit_phi = plot(ylims=(0.,1.05))
    cs_limits = range(eps(),0.5-eps(),length=1500)
	for ζ in 1:4
		ϕstars = ϕζcstar.(ζ,cs_limits)
		replace!(ϕstars,0=>NaN)
		color = colorname(ColorSchemes.seaborn_colorblind[ζ])
		plot!(cs_limits,ϕstars,color=color,linewidth=2,label="\$\\zeta=$ζ\$")
		plot!([cbarstar(ζ);cbarstar(ζ)],[0;ϕζcstar.(ζ,cbarstar(ζ)-eps())],color=color,linewidth=2,linestyle=:dash,label=false)
		plot!([cbarstar(ζ);0.5],[0,0],linewidth=2,color=color,label=false)
	end
	plot!(xlabel=L"\textrm{cost,} \ c",xlabelfontsize=7)
	plot!(ylabel=L"\textrm{limit \ success \ probability,} \phi_{\zeta,c}^*",ylabelfontsize=7)
    return pl_limit_phi
end

end # module